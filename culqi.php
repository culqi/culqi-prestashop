<?php
if (!defined('_PS_VERSION_'))
    exit;

define('CULQI_SDK_VERSION', '1.3.0');

/**
 * Calling dependencies
 */
include_once dirname(__FILE__).'/libraries/Requests/library/Requests.php';

Requests::register_autoloader();

include_once dirname(__FILE__).'/libraries/culqi-php/lib/culqi.php';


class Culqi extends PaymentModule
{

    private $_postErrors = array();

    const MODULE_NAME = "culqi";
    const MODULE_AUTHOR = "Team Culqi (Brayan Cruces)";
    const MODULE_NAME_DISP = "Culqi";

    public function __construct()
    {
        $this->name = 'culqi';
        $this->tab = 'payments_gateways';
        $this->version = '2.3.2';
        $this->controllers = array('chargeajax', 'payment', 'validation', 'postpayment', 'postpendingpayment', 'orderajax');
        $this->author = "Team Culqi (Brayan Cruces)";
        $this->need_instance = 0;
        $this->ps_versions_compliancy = array('min' => '1.5', 'max' => _PS_VERSION_);
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = 'Culqi';
        $this->description = $this->l('Acepta tarjetas de crédito y débito en tu tienda online.');
        $this->confirmUninstall = $this->l('¿Estás seguro que quieres desintalar el módulo de Culqi?');

    }

    public function install()
    {
        // Run sql for creating DB tables
        Db::getInstance()->execute("CREATE TABLE IF NOT EXISTS "._DB_PREFIX_."culqi_order (
            id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            culqi_charge_id varchar(255) NULL,
            amount int NULL,
            installments int NULL,
            email varchar(255) NULL,
            prestashop_order_id varchar(255) NULL
            ) ENGINE=" . _MYSQL_ENGINE_ . " DEFAULT CHARSET=utf8
          ");

        $this->createStates();

        return (
            parent::install() &&
            $this->registerHook('payment') &&
            $this->registerHook('paymentReturn') &&
            Configuration::updateValue('CULQI_LLAVE_COMERCIO', '') &&
            Configuration::updateValue('CULQI_CODIGO_COMERCIO', '')
        );
    }

    private function getAddress($address)
    {
        if(empty($address->address1)) {
            return $address->address2;
        } else {
            return $address->address1;
        }
    }

    private function getPhone($address)
    {
        if(empty($address->phone_mobile))
        {
            return $address->phone;
        } else {
            return $address->phone_mobile;
        }
    }

    private function getCustomerId()
    {
        if ($this->context->customer->isLogged())
        {
            return (int) $this->context->customer->id;
        } else {
            return 0;
        }
    }

    public function errorPayment($mensaje)
    {
        $smarty = $this->context->smarty;
        $smarty->assign('culqi_error_pago', $mensaje);
    }

    /* Se crea un Cargo con la nueva api v2 de Culqi PHP */
    public function charge($token_id, $installments)
    {
      try {

        $cart = $this->context->cart;

        $userAddress = new Address((int)$cart->id_address_invoice);
        $userCountry = new Country((int)$userAddress->id_country);

        $culqi = new Culqi\Culqi(array('api_key' => Configuration::get('CULQI_LLAVE_COMERCIO')));

        $amount = $this->removeComma($cart->getOrderTotal(true, Cart::BOTH));
        $email =  $this->context->customer->email;
        $order_id = (string)$cart->id;

        $cargo = $culqi->Charges->create(
            array(
              "amount" => $amount,
              "antifraud_details" => array(
                  "address" => $this->getAddress($userAddress),
                  "address_city" => $userAddress->city,
                  "country_code" => $userCountry->iso_code,
                  "first_name" => $this->context->customer->firstname,
                  "last_name" => $this->context->customer->lastname,
                  "phone_number" => $this->getPhone($userAddress)
              ),
              "capture" => true,
              "currency_code" => $this->context->currency->iso_code,
              "description" => "Orden de compra ".$cart->id,
              "installments" => $installments,
              "metadata" => array("order_id"=>$order_id),
              "email" => $email,
              "source_id" => $token_id
            )
        );

        if($cargo->object == "charge") {
          Db::getInstance()->insert('culqi_order', array(
              'culqi_charge_id'     => (string)$cargo->id,
              'amount'              => $amount,
              'installments'        => $installments,
              'email'               => $email,
              'prestashop_order_id' => $order_id
          ));
        }

        return $cargo;
      } catch(Exception $e){
        return $e->getMessage();
      }
    } 
    

    public function updateOrder($order_id) {

        try {

            $cart = $this->context->cart;   
            $OrderObject = new Order();
            $OrderObject = new Order($OrderObject->getOrderByCartId((int)$cart->id));

            $culqi = new Culqi\Culqi(array('api_key' => Configuration::get('CULQI_LLAVE_COMERCIO')));
  
            $order = $culqi->Orders->update($order_id,
              array(                
                "metadata" => array( 
                   "cart_id"=> (int)$cart->id,
                   "uid_module" => "123456789",
                   //"customer_secure_key" => $OrderObject->secure_key, 
                   "platform" => "ps-1.6"
                 )
              )
             ); 
             
             return $order;
  
        } catch(Exception $e) {
           echo' Error'; 
           error_log($e->getMessage());                    
        }     

    }
    


    public function createOrder() {  

        try {

          $cart = $this->context->cart; 
          $culqi = new Culqi\Culqi(array('api_key' => Configuration::get('CULQI_LLAVE_COMERCIO')));

          $order = $culqi->Orders->create(
            array(
              "amount" => $this->removeComma($cart->getOrderTotal(true, Cart::BOTH)),
              "currency_code" => $this->context->currency->iso_code,
              "description" => "Orden de compra ".$cart->id,        
              "order_number" => "ps-".$cart->id."-".rand(1, 99999), 
              "client_details" => array( 
                 "first_name"=> $this->context->customer->firstname,
                 "last_name" => $this->context->customer->lastname,
                 "email" => $this->context->customer->email, 
                 "phone_number" => "+51945145282"
               ),
               "confirm" => false,
               "expiration_date" => time() + Configuration::get('CULQI_ORDER_MAX_DURATION')*60*60  
            )
           ); 
           
           return $order;

        } catch(Exception $e) {
          return $e->getMessage();  
        }
                
    } 

    public function hookPayment($params)
    {
        if (!$this->active)
        {
          return;
        }
        if (!$this->checkCurrency($params['cart']))
        {
          return;
        }
        $this->smarty->assign(array(
            'this_path' => $this->_path,
            'this_path_ssl' => Tools::getShopDomainSsl(true, true).__PS_BASE_URI__.'modules/'.$this->name.'/'
        )); 

        if(Configuration::get('CULQI_ENABLED_MULTIPAYMENT')) return $this->display(__FILE__, 'payment_multi.tpl'); 

        return $this->display(__FILE__, 'payment.tpl'); 
    }

    public function hookPaymentReturn($params)
    {
        if (!$this->active)
        {
          return;
        }  


        $state = $params['objOrder']->getCurrentState();

        if($state == Configuration::get('CULQI_STATE_PENDING')) {
         
            $this->smarty->assign(
                array(
                    'status' => 'pending'
                )
            );
        }
        else {
            $this->smarty->assign(
                array(
                    'status' => 'ok'
                )
            );
        }

        
        return $this->display(__FILE__, 'payment_return.tpl');
    }

    public function checkCurrency($cart)
    {
        $currency_order = new Currency((int)($cart->id_currency));
        $currencies_module = $this->getCurrency((int)$cart->id_currency);

        if (is_array($currencies_module))
        {
          foreach ($currencies_module as $currency_module)
          {
            if ($currency_order->id == $currency_module['id_currency'])
            {
              return true;
            }
          }
        }

        return false;
    }

    public function uninstallStates()
    {
        if (Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_OK' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state_lang WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_OK' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_ERROR' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state_lang WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_ERROR' )") &&  
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_PENDING' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state_lang WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_PENDING' )" ) && 
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_EXPIRED' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state_lang WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_EXPIRED' )")    
        ) return true;
        return false;
    }

    public function uninstall()
    {
        Db::getInstance()->execute('DROP TABLE IF EXISTS '._DB_PREFIX_.'culqi_order');

        if (!parent::uninstall()
        || !Configuration::deleteByName('CULQI_STATE_OK')
        || !Configuration::deleteByName('CULQI_STATE_ERROR')
        || !Configuration::deleteByName('CULQI_STATE_PENDING')
        || !Configuration::deleteByName('CULQI_STATE_EXPIRED')
        || !Configuration::deleteByName('CULQI_LLAVE_COMERCIO')
        || !Configuration::deleteByName('CULQI_CODIGO_COMERCIO') 
        || !Configuration::deleteByName('CULQI_ENABLED_MULTIPAYMENT')           
        || !Configuration::deleteByName('CULQI_ORDER_MAX_DURATION')   
        || !$this->uninstallStates())
            return false;
        return true;
    }

    private function _postValidation()
    {
        if (Tools::isSubmit('btnSubmit'))
        {
            if (!Tools::getValue('CULQI_LLAVE_COMERCIO'))
            {
              $this->_postErrors[] = $this->l('El campo llave de comercio es requerido.');
            }

            if (!Tools::getValue('CULQI_CODIGO_COMERCIO'))
            {
              $this->_postErrors[] = $this->l('El campo código de comercio es requerido.');
            }  

            // Añadir validacion si es que habilitado 
        }
    }

    private function _displayInfo()
    {
        return $this->display(__FILE__, 'info.tpl');
    }

    public function getContent()
    {
        $this->_html = '';

        if (Tools::isSubmit('btnSubmit'))
        {
            $this->_postValidation();
            if (!count($this->_postErrors))
            {
              $this->_postProcess();
            } else {
              foreach ($this->_postErrors as $err) {
                $this->_html .= $this->displayError($err);
              }
            }
        }

        $this->_html .= $this->_displayInfo();
        $this->_html .= $this->renderForm();

        return $this->_html;
    }

    private function createStates()
    {
        if (!Configuration::get('CULQI_STATE_OK'))
        {
            $order_state = new OrderState();
            $order_state->name = array();
            foreach (Language::getLanguages() as $language) {
              $order_state->name[$language['id_lang']] = 'Exitoso';
            }
            $order_state->send_email = false;
            $order_state->color = '#39CC98';
            $order_state->hidden = false;
            $order_state->paid = true;
            $order_state->module_name = 'culqi';
            $order_state->delivery = false;
            $order_state->logable = false;
            $order_state->invoice = true;
            $order_state->pdf_invoice = true;
            $order_state->add();
            Configuration::updateValue('CULQI_STATE_OK', (int)$order_state->id);
        } 


        if (!Configuration::get('CULQI_STATE_PENDING'))
        {
            $order_state = new OrderState();
            $order_state->name = array();
            foreach (Language::getLanguages() as $language) {
              $order_state->name[$language['id_lang']] = 'Pendiente de pago';
            }
            $order_state->send_email = false;
            $order_state->color = '#d3f237';
            $order_state->module_name = 'culqi';
            $order_state->hidden = false;
            $order_state->delivery = false;
            $order_state->logable = false;
            $order_state->invoice = false;
            $order_state->add();
            Configuration::updateValue('CULQI_STATE_PENDING', (int)$order_state->id);
        } 

        if (!Configuration::get('CULQI_STATE_EXPIRED'))
        {
            $order_state = new OrderState();
            $order_state->name = array();
            foreach (Language::getLanguages() as $language) {
              $order_state->name[$language['id_lang']] = 'Orden expirada';
            }
            $order_state->send_email = false;
            $order_state->color = '#9ea095';
            $order_state->module_name = 'culqi';
            $order_state->hidden = false;
            $order_state->delivery = false;
            $order_state->logable = false;
            $order_state->invoice = false;
            $order_state->add();
            Configuration::updateValue('CULQI_STATE_EXPIRED', (int)$order_state->id);
        }

        if (!Configuration::get('CULQI_STATE_ERROR'))
        {
            $order_state = new OrderState();
            $order_state->name = array();
            foreach (Language::getLanguages() as $language) {
              $order_state->name[$language['id_lang']] = 'Incorrecto';
            }
            $order_state->send_email = false;
            $order_state->color = '#FF2843';
            $order_state->module_name = 'culqi';
            $order_state->hidden = false;
            $order_state->delivery = false;
            $order_state->logable = false;
            $order_state->invoice = false;
            $order_state->add();
            Configuration::updateValue('CULQI_STATE_ERROR', (int)$order_state->id);
        }
    }


    /**
     * Admin Zone
     */
    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('CONFIGURACIÓN DE CULQI'),
                    'icon' => 'icon-money'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('Llave Pública'),
                        'name' => 'CULQI_CODIGO_COMERCIO', 
                        'desc' => 'Ejemplo: pk_live_gtXeGlE5p5z8EXNt',
                        'required' => true, 

                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Llave Secreta'),
                        'name' => 'CULQI_LLAVE_COMERCIO', 
                        'desc' => 'Ejemplo: sk_live_yw9bvW94E59t0ATk',
                        'required' => true
                    ), 
                    array(
                        'type' => 'switch',  
                        'label' => $this->l('Habilitar pago con efectivo (BETA)'), 
                        'desc' => 'Permite habilitar el modo multipagos de Culqi. Aceptar tarjetas de crédito/débito y pagos en efectivo. Más información <a target="_blank" href="https://culqi.com/docs/#/multipagos/inicio">aquí</a>',
                        'name' => 'CULQI_ENABLED_MULTIPAYMENT', 
                        'is_bool' => true,
                        'required' => true,  
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Yes')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('No')
                            )
                        ),
                    ), 
                    array(
                        'type' => 'text',
                        'label' => $this->l('Tiempo de duración máxima de las órdenes'),
                        'name' => 'CULQI_ORDER_MAX_DURATION',
                        'required' => false, 
                        'hint' => 'Colocar un numero entero. Ejemplo: 2 o 24.',              
                        'desc' => 'Tiempo de duración de las ordenes creadas, en horas. Por ejemplo 24 hrs (1 día), pasado esta tiempo las órdenes expirarán.'
                    ),  

                    array(
                        'type' => 'text',
                        'label' => $this->l('URL de webhook'),
                        'name' => 'CULQI_ORDER_WEBHOOK',
                        'disabled' => true, 
                        'hint' => 'A esta URL se enviarán las notificaciones de cambios de estado de una orden. Por ejemplo cuando fue pagada o expiró. Es obligatorio crear el webhook dentro del Panel Culqi.',  
                        'desc' => '<b>OBLIGATORIO.</b> Pega esta URL dentro de la sección de Eventos > Webhooks en el panel de Culqi. Crea un webhook del tipo "order.status.changed"'                     
                    ),                  
                    
                ),
                'submit' => array(
                    'title' => $this->l('Guardar'),
                )
            ),
        );

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $this->fields_form = array();
        $helper->id = (int)Tools::getValue('id_carrier');
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'btnSubmit';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        return array(
            'CULQI_LLAVE_COMERCIO' => Tools::getValue('CULQI_LLAVE_COMERCIO', Configuration::get('CULQI_LLAVE_COMERCIO')),
            'CULQI_CODIGO_COMERCIO' => Tools::getValue('CULQI_CODIGO_COMERCIO', Configuration::get('CULQI_CODIGO_COMERCIO')), 
            'CULQI_ENABLED_MULTIPAYMENT' => Tools::getValue('CULQI_ENABLED_MULTIPAYMENT', Configuration::get('CULQI_ENABLED_MULTIPAYMENT')), 
            'CULQI_ORDER_MAX_DURATION' => Tools::getValue('CULQI_ORDER_MAX_DURATION', Configuration::get('CULQI_ORDER_MAX_DURATION')), 
            'CULQI_ORDER_WEBHOOK' => Tools::getValue('CULQI_ORDER_WEBHOOK', _PS_BASE_URL_.__PS_BASE_URI__."modules/culqi/culqi_webhook.php")           

        );
    }

    private function _postProcess()
    {
        if (Tools::isSubmit('btnSubmit'))
        {
            Configuration::updateValue('CULQI_LLAVE_COMERCIO', Tools::getValue('CULQI_LLAVE_COMERCIO'));
            Configuration::updateValue('CULQI_CODIGO_COMERCIO', Tools::getValue('CULQI_CODIGO_COMERCIO'));
            Configuration::updateValue('CULQI_ENABLED_MULTIPAYMENT', Tools::getValue('CULQI_ENABLED_MULTIPAYMENT'));
            Configuration::updateValue('CULQI_ORDER_MAX_DURATION', Tools::getValue('CULQI_ORDER_MAX_DURATION'));
        }
        $this->_html .= $this->displayConfirmation($this->l('Se actualizaron las configuraciones'));
    }

    public function removeComma($amount) {
        return str_replace(".","",str_replace(',', '', number_format($amount,2,'.',',')));
    } 

    
    public function validationCulqi() 
    {
        error_log('Llego petición al Webhook');   

        $data = json_decode(file_get_contents('php://input'), true); 
        $eventOrderStatus = 'order.status.changed';
        
        error_log($data['data']);                         
        
        if($data['type'] == $eventOrderStatus) {        

           $objectOrder =  json_decode($data['data'], true);            
           error_log('Evento de cambio de orden');   

           // Get parameters 
           $currencyCode = trim($objectOrder['currency_code']);
           $state = trim($objectOrder['state']);
           $amount = trim($objectOrder['amount']);               

           // Metadata 
           $metadata = $objectOrder['metadata']; 
           //$reference = trim($metadata['reference']);
           $cartID = $metadata['cart_id']; 
           error_log($cartID);
           //$uidModule = trim($metadata['uid_module']); 
           //$customerSecureKey = trim($metadata['customer_secure_key']);       
           
           //$PS_UidModule =  trim(Tools::safeOutput(Configuration::get('PAYGOL_SECRETKEY')));


           // Validación  
           /*if( empty($uidModule)){
            exit("Error: Codigo identificador invalido"); 
           }*/

           if (empty($metadata)) {
            exit("Error: Metadata vacia"); 
           } 

           if (empty($amount) || empty($currencyCode) || empty($state)) {
            exit("Error: valores de la orden incorrectos"); 
           }  

           if(Tools::strlen($cartID) < 1){
            exit("Error: Valores personalizados incorrectos");
           } 

           if (Validate::isLoadedObject(new Cart($cartID))) {
            $ObjCart = new Cart($cartID);
           } else {
             exit("Error: El carrito no existe");
           } 

           // Validar carro con informacion de orden  

           //$priceValidation = $this->validateTotalPaid($cartID, $frmPrice, $frmCurrency);

          if ($ObjCart->orderExists() > 0 ) {
             $OrderObject = new Order();
             $OrderObject = new Order($OrderObject->getOrderByCartId($ObjCart->id));
                
            /*if ($customerSecureKey != $OrderObject->secure_key || $customerSecureKey != $ObjCart->secure_key) {
                exit("Error: Secure key does not match");
            }*/
                    
            /*if ($customerID != $OrderObject->id_customer || $customerID != $ObjCart->id_customer) {
                exit("Error: Customer ID does not match");
            }*/

            if ((int)Configuration::get('CULQI_STATE_OK') == $OrderObject->current_state) {
                exit("WEBHOOK CALLBACK: La orden ya esta completa");
            } else {  
                
                // Orden pagada
                if($state == 'paid') { 
                    error_log('Estado: Pagada'); 
                    $OrderObject->setCurrentState((int)Configuration::get('CULQI_STATE_OK')); 
                }

                // Orden expirada
                if($state == 'expired') { 
                    error_log('Estado: Expirada'); 
                    $OrderObject->setCurrentState((int)Configuration::get('CULQI_STATE_EXPIRED'));

                }
                exit("WEBHOOK CALLBACK: OK");
            }
          }        
                        

        }            


    }


  }


class CulqiPago
{
    public static $llaveSecreta;
    public static $codigoComercio;
}
