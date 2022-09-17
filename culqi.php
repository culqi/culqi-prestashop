<?php

//use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

if (!defined('_PS_VERSION_'))
    exit;

define('CULQI_SDK_VERSION', '1.3.0');

define('URLAPI_INTEG', 'https://qa-test-panel.culqi.xyz');
define('URLAPI_PROD', 'https://qa-panel.culqi.xyz');

define('URLAPI_INTEG_3DS', 'https://3ds-qa.culqi.xyz/');
define('URLAPI_PROD_3DS', 'https://3ds-qa.culqi.xyz');

define('URLAPI_ORDERCHARGES_INTEG', 'https://qa-api.culqi.xyz/v2');
define('URLAPI_CHECKOUT_INTEG', 'https://qa-checkout.culqi.xyz/js/v4');
define('URLAPI_LOGIN_INTEG', URLAPI_INTEG.'/user/login');
define('URLAPI_MERCHANT_INTEG', URLAPI_INTEG.'/secure/merchant/');
define('URLAPI_MERCHANTSINGLE_INTEG', URLAPI_INTEG.'/secure/keys/?merchant=');
define('URLAPI_WEBHOOK_INTEG', URLAPI_INTEG.'/secure/events');

define('URLAPI_ORDERCHARGES_PROD', 'https://qa-api.culqi.xyz/v2');
define('URLAPI_CHECKOUT_PROD', 'https://qa-checkout.culqi.xyz/js/v4');
define('URLAPI_LOGIN_PROD', URLAPI_PROD.'/user/login');
define('URLAPI_MERCHANT_PROD', URLAPI_PROD.'/secure/merchant/');
define('URLAPI_MERCHANTSINGLE_PROD', URLAPI_PROD.'/secure/keys/?merchant=');
define('URLAPI_WEBHOOK_PROD', URLAPI_PROD.'/secure/events');


/**
 * Calling dependencies
 */
include_once dirname(__FILE__).'/libraries/Requests/library/Requests.php';

Requests::register_autoloader();

//include_once dirname(__FILE__).'/libraries/culqi-php/lib/culqi.php';

class Culqi extends PaymentModule
{

    private $_postErrors = array();

    public function __construct()
    {
        $this->name = 'culqi';
        $this->tab = 'payments_gateways';
        $this->version = '3.0.0';
        $this->controllers = array('chargeajax','postpayment', 'generateorder', 'merchantajax', 'webhook', 'registersale');
        $this->author = 'Culqi';
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
        $this->bootstrap = true;
        $this->display = 'view';

        parent::__construct();

        $this->meta_title = 'Culqi';
        $this->displayName = 'Culqi Checkout';
        $this->description = $this->l('Conéctate a nuestra pasarela de pagos para aumentar tus ventas.');
        $this->confirmUninstall = $this->l('¿Estás seguro que quieres desintalar el módulo de Culqi?');

    }

    public function install()
    {
        $this->createStates();

        return (
            parent::install() &&
            $this->registerHook('paymentOptions') &&
            $this->registerHook('payment') &&
            $this->registerHook('paymentReturn') &&
            Configuration::updateValue('CULQI_ENABLED', '') &&
            Configuration::updateValue('CULQI_ENVIROMENT', '') &&
            Configuration::updateValue('CULQI_LLAVE_SECRETA', '') &&
            Configuration::updateValue('CULQI_LLAVE_PUBLICA', '') &&
            Configuration::updateValue('CULQI_METHODS_TARJETA', '') &&
            Configuration::updateValue('CULQI_METHODS_BANCAMOVIL', '') &&
            Configuration::updateValue('CULQI_METHODS_AGENTS', '') &&
            Configuration::updateValue('CULQI_METHODS_WALLETS', '') &&
            Configuration::updateValue('CULQI_METHODS_QUOTEBCP', '') &&
            Configuration::updateValue('CULQI_TIMEXP', '') &&
            Configuration::updateValue('CULQI_NOTPAY', '') &&
            Configuration::updateValue('CULQI_URL_LOGO', '') && 
            Configuration::updateValue('CULQI_COLOR_PALETTE', '')
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
        //var_dump('hi');
      try {

        $cart = $this->context->cart;

        $userAddress = new Address((int)$cart->id_address_invoice);
        $userCountry = new Country((int)$userAddress->id_country);

        $culqi = new Culqi\Culqi(array('api_key' => Configuration::get('CULQI_LLAVE_SECRETA')));

        $charge = $culqi->Charges->create(
            array(
              "amount" => $this->removeComma($cart->getOrderTotal(true, Cart::BOTH)),
              "antifraud_details" => array(
                  "address" => $this->getAddress($userAddress),
                  "address_city" => $userAddress->city,
                  "country_code" => "PE",
                  "first_name" => $this->context->customer->firstname,
                  "last_name" => $this->context->customer->lastname,
                  "phone_number" => $this->getPhone($userAddress)
              ),
              "capture" => true,
              "currency_code" => $this->context->currency->iso_code,
              "description" => "Orden de compra ".$cart->id,
              "installments" => $installments,
              "metadata" => array("order_id"=>(string)$cart->id),
              "email" => $this->context->customer->email,
              "source_id" => $token_id
            )
        );
        //return $cargo;
        return $charge;
      } catch(Exception $e){
        return $e->getMessage();
      }

    }

    public function hookPaymentOptions($params)
    {
        if (!$this->active)
        {
          return;
        }
        if (!$this->checkCurrency($params['cart']))
        {
          return;
        }

        $newOption = new PaymentOption();

        $this->context->smarty->assign(
          $this->getCulqiInfoCheckout()
        );
        //var_dump($this->getCulqiInfoCheckout()); exit(1);

        $newOption->setModuleName($this->name)
                  ->setCallToActionText($this->trans('Pagar con Culqi', array(), 'culqi'))
                  ->setAction($this->context->link->getModuleLink($this->name, 'postpayment', array(), true))
                  //->setAdditionalInformation($this->context->smarty->fetch('module:culqi/views/templates/hook/payment.tpl'));;
                  ->setAdditionalInformation($this->context->smarty->fetch('module:culqi/views/templates/hook/paymentCulqi.tpl'));;
                  //->setLogo(Media::getMediaPath(_PS_MODULE_DIR_.$this->name.'/views/img/logo_cards.png'));;

        $payment_options = [
            $newOption,
        ];

        return $payment_options;
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
        if(Configuration::get('CULQI_ENABLED')) return $this->display(__FILE__, 'payment_multi.tpl');

        return $this->display(__FILE__, 'paymentCulqi.tpl');
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

    public function getCulqiInfoCheckout() {

        $cart = $this->context->cart;
        $address = Db::getInstance()->ExecuteS("SELECT * FROM " . _DB_PREFIX_ . "address where id_address=" . $cart->id_address_invoice);
        //var_dump($currency); exit(1);
        $total = Tools::ps_round($cart->getOrderTotal(true, Cart::BOTH),  _PS_PRICE_DISPLAY_PRECISION_);
        //$total = Tools::ps_round($cart->getOrderTotal(true, Cart::BOTH), PS_PRICE_DISPLAY_PRECISION);
        //var_dump(PS_PRICE_DISPLAY_PRECISION); exit(1);
        //$total = $cart->getOrderTotal(true, Cart::BOTH);
        //var_dump($this->context->currency); exit(1);
        $color_palette = Configuration::get('CULQI_COLOR_PALETTE');
        $total = $total * 100;

        $urlapi_ordercharges = URLAPI_ORDERCHARGES_INTEG;
        $urlapi_checkout = URLAPI_CHECKOUT_INTEG;
        $urlapi_3ds = URLAPI_INTEG_3DS;
        if(Configuration::get('CULQI_ENVIROMENT')=='prod'){
            $urlapi_ordercharges = URLAPI_ORDERCHARGES_PROD;
            $urlapi_checkout = URLAPI_CHECKOUT_PROD;
            $urlapi_3ds = URLAPI_PROD_3DS;
        }
        $https = isset($_SERVER['HTTP_X_FORWARDED_PROTO']) ? $_SERVER['HTTP_X_FORWARDED_PROTO'] : null;
        if(is_null($https)){
            $https = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http";
        }
        $base_url = $https . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
        $base_url = $https . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
        return array(
            "psversion" => $this->ps_versions_compliancy['max'],
            "module_dir" => $this->_path,
            "descripcion" => "Orden de compra ".$cart->id,
            "orden" => $cart->id,
            "total" => $total,
            "enviroment_backend" => $urlapi_ordercharges,
            "enviroment_fronted" => $urlapi_checkout,
            "enviroment_3ds" => $urlapi_3ds,
            "llave_publica" => Configuration::get('CULQI_LLAVE_PUBLICA'),
            "llave_secreta" => Configuration::get('CULQI_LLAVE_SECRETA'),
            "tarjeta" => Configuration::get('CULQI_METHODS_TARJETA') == 'yes' ? 'true' : 'false',
            "banca_movil" => Configuration::get('CULQI_METHODS_BANCAMOVIL') == 'yes' ? 'true' : 'false',
            "yape" => Configuration::get('CULQI_METHODS_yape') == 'yes' ? 'true' : 'false',
            "billetera" => Configuration::get('CULQI_METHODS_WALLETS') == 'yes' ? 'true' : 'false',
            "agente" => Configuration::get('CULQI_METHODS_AGENTS') == 'yes' ? 'true' : 'false',
            "cuetealo" => Configuration::get('CULQI_METHODS_QUOTEBCP') == 'yes' ? 'true' : 'false',
            "url_logo" => Configuration::get('CULQI_URL_LOGO'),
            "tiempo_exp" => (Configuration::get('CULQI_TIMEXP') == '' ? 24 : Configuration::get('CULQI_TIMEXP')),
            "color_pallete" => explode('-', $color_palette),
            "currency" => $this->context->currency->iso_code,
            "address" => $address,
            "customer" => $this->context->customer,
            'commerce' => Configuration::get('PS_SHOP_NAME'),
            "BASE_URL" => $base_url
        );
    }

    public function uninstallStates()
    {
        if (Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_OK' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state_lang WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_OK' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_PENDING' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state_lang WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_PENDING' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_ERROR' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state_lang WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_ERROR' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_EXPIRED' )") &&
            Db::getInstance()->Execute("DELETE FROM " . _DB_PREFIX_ . "order_state_lang WHERE id_order_state = ( SELECT value
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_EXPIRED' )")
        ) return true;
        return false;
    }

    public function uninstall()
    {
        if (!parent::uninstall()
            || !Configuration::deleteByName('CULQI_STATE_OK')
            || !Configuration::deleteByName('CULQI_STATE_PENDING')
            || !Configuration::deleteByName('CULQI_STATE_ERROR')
            || !Configuration::deleteByName('CULQI_STATE_EXPIRED')
            || !Configuration::deleteByName('CULQI_ENABLED')
            || !Configuration::deleteByName('CULQI_ENVIROMENT')
            || !Configuration::deleteByName('CULQI_LLAVE_SECRETA')
            || !Configuration::deleteByName('CULQI_LLAVE_PUBLICA')
            || !Configuration::deleteByName('CULQI_METHODS_TARJETA')
            || !Configuration::deleteByName('CULQI_METHODS_BANCAMOVIL')
            || !Configuration::deleteByName('CULQI_METHODS_YAPE')
            || !Configuration::deleteByName('CULQI_METHODS_AGENTS')
            || !Configuration::deleteByName('CULQI_METHODS_WALLETS')
            || !Configuration::deleteByName('CULQI_METHODS_QUOTEBCP')
            || !Configuration::deleteByName('CULQI_TIMEXP')
            || !Configuration::deleteByName('CULQI_NOTPAY')
            || !Configuration::deleteByName('CULQI_URL_LOGO')
            || !Configuration::deleteByName('CULQI_COLOR_PALETTE')
            || !$this->uninstallStates())
            return false;
        return true;
    }

    private function _postValidation()
    {
        if (Tools::isSubmit('btnSubmit'))
        {
            if (!Tools::getValue('CULQI_LLAVE_SECRETA'))
            {
              $this->_postErrors[] = $this->l('El campo llave de comercio es requerido.');
            }

            if (!Tools::getValue('CULQI_LLAVE_PUBLICA'))
            {
              $this->_postErrors[] = $this->l('El campo código de comercio es requerido.');
            }
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

        //$this->_html .= $this->_displayInfo();
        $this->_html .= $this->renderForm();

        return $this->_html;
    }

    private function createStates()
    {
        if (!Configuration::get('CULQI_STATE_OK')) {
            $txt_state='Pago aceptado';
            $orderstate = Db::getInstance()->ExecuteS("SELECT distinct osl.id_order_state, osl.name FROM " . _DB_PREFIX_ . "order_state_lang osl, " . _DB_PREFIX_ . "order_state os where osl.id_order_state=os.id_order_state and osl.name='" . $txt_state . "' and deleted=0");
            Configuration::updateValue('CULQI_STATE_OK', (int)$orderstate[0]['id_order_state']);
        }
        if (!Configuration::get('CULQI_STATE_PENDING')) {
            $txt_state = 'En espera de pago por Culqi';
            $rows = Db::getInstance()->getValue($this->queryGetStates($txt_state));
            if (intval($rows) == 0) {
                $order_state = new OrderState();
                $order_state->name = array();
                foreach (Language::getLanguages() as $language) {
                    $order_state->name[$language['id_lang']] = $txt_state;
                }
                $order_state->send_email = false;
                $order_state->color = '#34209E';
                $order_state->hidden = false;
                $order_state->paid = true;
                $order_state->module_name = 'culqi';
                $order_state->delivery = false;
                $order_state->logable = false;
                $order_state->invoice = true;
                $order_state->pdf_invoice = true;
                $order_state->add();
                Configuration::updateValue('CULQI_STATE_PENDING', (int)$order_state->id);
            } else {
                $orderstate = Db::getInstance()->ExecuteS("SELECT distinct id_order_state, name FROM " . _DB_PREFIX_ . "order_state_lang where name='" . $txt_state . "'");
                Configuration::updateValue('CULQI_STATE_PENDING', (int)$orderstate[0]['id_order_state']);
            }
        }
        if (!Configuration::get('CULQI_STATE_ERROR')) {
            $txt_state = 'Incorrecto - Culqi';
            $rows = Db::getInstance()->getValue($this->queryGetStates($txt_state));
            if (intval($rows) == 0) {
                $order_state = new OrderState();
                $order_state->name = array();
                foreach (Language::getLanguages() as $language) {
                    $order_state->name[$language['id_lang']] = $txt_state;
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
            } else {
                $orderstate = Db::getInstance()->ExecuteS("SELECT distinct osl.id_order_state, osl.name FROM " . _DB_PREFIX_ . "order_state_lang osl, " . _DB_PREFIX_ . "order_state os where osl.id_order_state=os.id_order_state and osl.name='" . $txt_state . "' and deleted=0");
                Configuration::updateValue('CULQI_STATE_ERROR', (int)$orderstate[0]['id_order_state']);
            }
        }
        if (!Configuration::get('CULQI_STATE_EXPIRED')) {
            $txt_state = 'Expirado por Culqi';
            $rows = Db::getInstance()->getValue($this->queryGetStates($txt_state));
            if (intval($rows) == 0) {
                $order_state = new OrderState();
                $order_state->name = array();
                foreach (Language::getLanguages() as $language) {
                    $order_state->name[$language['id_lang']] = $txt_state;
                }
                $order_state->send_email = false;
                $order_state->color = '#ADADAD';
                $order_state->module_name = 'culqi';
                $order_state->hidden = false;
                $order_state->delivery = false;
                $order_state->logable = false;
                $order_state->invoice = false;
                $order_state->add();
                Configuration::updateValue('CULQI_STATE_EXPIRED', (int)$order_state->id);
            } else {
                $orderstate = Db::getInstance()->ExecuteS("SELECT distinct osl.id_order_state, osl.name FROM " . _DB_PREFIX_ . "order_state_lang osl, " . _DB_PREFIX_ . "order_state os where osl.id_order_state=os.id_order_state and osl.name='" . $txt_state . "' and deleted=0");
                Configuration::updateValue('CULQI_STATE_EXPIRED', (int)$orderstate[0]['id_order_state']);
            }
        }
    }

    private function queryGetStates($txt_state)
    {
        $query = "SELECT count(*) as filas FROM  " . _DB_PREFIX_ . "order_state a,  " . _DB_PREFIX_ . "order_state_lang b WHERE b.id_order_state = a.id_order_state AND a.deleted = 0 AND name='" . $txt_state . "'";
        return $query;
    }

    /**
     * Admin Zone
     */
    /* public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('CONFIGURACIONES GENERALES CULQI'),
                    'icon' => 'icon-money'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('Llave Pública'),
                        'name' => 'CULQI_LLAVE_PUBLICA',
                        'required' => true
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Llave Secreta'),
                        'name' => 'CULQI_LLAVE_SECRETA',
                        'required' => true
                    )
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
    } */

    public function renderForm()
    {
        $config = $this->getConfigFieldsValues();
        //var_dump(Tools::getAdminTokenLite('AdminModules')); exit(1);
        $this->context->smarty->assign(array (
            'currentIndex' => $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name,
            'token' => Tools::getAdminTokenLite('AdminModules'),
            'fields_value' => $this->getConfigFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
            'status_enabled' => $config['CULQI_ENABLED'] == 'yes' ? 'checked' : '',
            'status_methods_tarjeta_enabled' => $config['CULQI_METHODS_TARJETA'] == 'yes' ? 'checked' : '',
            'status_methods_bancamovil_enabled' => $config['CULQI_METHODS_BANCAMOVIL'] == 'yes' ? 'checked' : '',
            'status_methods_yape_enabled' => $config['CULQI_METHODS_YAPE'] == 'yes' ? 'checked' : '',
            'status_methods_agents_enabled' => $config['CULQI_METHODS_AGENTS'] == 'yes' ? 'checked' : '',
            'status_methods_wallets_enabled' => $config['CULQI_METHODS_WALLETS'] == 'yes' ? 'checked' : '',
            'status_methods_quotebcp_enabled' => $config['CULQI_METHODS_QUOTEBCP'] == 'yes' ? 'checked' : ''
        ));
        //var_dump(__FILE__); exit(1);
        return $this->display(__FILE__, '/views/templates/hook/setting.tpl');
    } 

    public function getConfigFieldsValues()
    {
        $checked_integ = 'checked="true"';
        $checked_prod = '';
        $urlapi_login = URLAPI_LOGIN_INTEG;
        $urlapi_merchant = URLAPI_MERCHANT_INTEG;
        $urlapi_merchantsingle = URLAPI_MERCHANTSINGLE_INTEG;
        $urlapi_webhook = URLAPI_WEBHOOK_INTEG;
        if(Configuration::get('CULQI_ENVIROMENT')=='prod'){
            $checked_integ = '';
            $checked_prod = 'checked="true"';
            $urlapi_login = URLAPI_LOGIN_PROD;
            $urlapi_merchant = URLAPI_MERCHANT_PROD;
            $urlapi_merchantsingle = URLAPI_MERCHANTSINGLE_PROD;
            $urlapi_webhook = URLAPI_WEBHOOK_PROD;
        }
        $post = 0;
        if(isset($_POST['btnSubmit']) and $_POST['btnSubmit']==1){
            $post = 1;
        }
        $errors = count($this->_postErrors);
        return array(
            'CULQI_ENABLED' => Tools::getValue('CULQI_ENABLED', Configuration::get('CULQI_ENABLED')),
            'CULQI_ENVIROMENT' => Tools::getValue('CULQI_ENVIROMENT', Configuration::get('CULQI_ENVIROMENT')),
            'CULQI_LLAVE_SECRETA' => Tools::getValue('CULQI_LLAVE_SECRETA', Configuration::get('CULQI_LLAVE_SECRETA')),
            'CULQI_LLAVE_PUBLICA' => Tools::getValue('CULQI_LLAVE_PUBLICA', Configuration::get('CULQI_LLAVE_PUBLICA')),
            'CULQI_METHODS_TARJETA' => Tools::getValue('CULQI_METHODS_TARJETA', Configuration::get('CULQI_METHODS_TARJETA')),
            'CULQI_METHODS_BANCAMOVIL' => Tools::getValue('CULQI_METHODS_BANCAMOVIL', Configuration::get('CULQI_METHODS_BANCAMOVIL')),
            'CULQI_METHODS_YAPE' => Tools::getValue('CULQI_METHODS_YAPE', Configuration::get('CULQI_METHODS_YAPE')),
            'CULQI_METHODS_AGENTS' => Tools::getValue('CULQI_METHODS_AGENTS', Configuration::get('CULQI_METHODS_AGENTS')),
            'CULQI_METHODS_WALLETS' => Tools::getValue('CULQI_METHODS_WALLETS', Configuration::get('CULQI_METHODS_WALLETS')),
            'CULQI_METHODS_QUOTEBCP' => Tools::getValue('CULQI_METHODS_QUOTEBCP', Configuration::get('CULQI_METHODS_QUOTEBCP')),
            'CULQI_TIMEXP' => Tools::getValue('CULQI_TIMEXP', Configuration::get('CULQI_TIMEXP')),
            'CULQI_NOTPAY' => Tools::getValue('CULQI_NOTPAY', Configuration::get('CULQI_NOTPAY')),
            'CULQI_URL_LOGO' => Tools::getValue('CULQI_URL_LOGO', Configuration::get('CULQI_URL_LOGO')),
            'CULQI_COLOR_PALETTE' => Tools::getValue('CULQI_COLOR_PALETTE', Configuration::get('CULQI_COLOR_PALETTE')),
            'CULQI_COLOR_PALETTEID' => str_replace('#', '', Tools::getValue('CULQI_COLOR_PALETTE', Configuration::get('CULQI_COLOR_PALETTE'))),
            'CULQI_CHECKED_INTEG' => $checked_integ,
            'CULQI_CHECKED_PROD' => $checked_prod,
            'CULQI_URL_LOGIN'=>$urlapi_login,
            'CULQI_URL_MERCHANT'=>$urlapi_merchant,
            'CULQI_URL_MERCHANTSINGLE'=>$urlapi_merchantsingle,
            'CULQI_URL_WEBHOOK'=>$urlapi_webhook,
            'CULQI_URL_MERCHANTSINGLE_CULQI'=>$this->context->link->getModuleLink($this->name, 'merchantajax', array(), true),
            'CULQI_URL_WEBHOOK_PS'=>$this->context->link->getModuleLink($this->name, 'webhook', array(), true),
            'CULQI_POST' => $post,
            'URLAPI_LOGIN_INTEG' => URLAPI_LOGIN_INTEG,
            'URLAPI_MERCHANT_INTEG' => URLAPI_MERCHANT_INTEG,
            'URLAPI_MERCHANTSINGLE_INTEG' => URLAPI_MERCHANTSINGLE_INTEG,
            'URLAPI_WEBHOOK_INTEG' => URLAPI_WEBHOOK_INTEG,
            'URLAPI_LOGIN_PROD' => URLAPI_LOGIN_PROD,
            'URLAPI_MERCHANT_PROD' => URLAPI_MERCHANT_PROD,
            'URLAPI_MERCHANTSINGLE_PROD' => URLAPI_MERCHANTSINGLE_PROD,
            'URLAPI_WEBHOOK_PROD' => URLAPI_WEBHOOK_PROD,
            'CULQI_POST_ERRORS'=>$errors,
            'commerce'=>Configuration::get('PS_SHOP_NAME')
        );
    }

    private function _postProcess()
    {
        if (Tools::isSubmit('btnSubmit'))
        {
            Configuration::updateValue('CULQI_ENABLED', Tools::getValue('CULQI_ENABLED'));
            Configuration::updateValue('CULQI_ENVIROMENT', Tools::getValue('CULQI_ENVIROMENT'));
            Configuration::updateValue('CULQI_LLAVE_SECRETA', Tools::getValue('CULQI_LLAVE_SECRETA'));
            Configuration::updateValue('CULQI_LLAVE_PUBLICA', Tools::getValue('CULQI_LLAVE_PUBLICA'));
            Configuration::updateValue('CULQI_METHODS_TARJETA', Tools::getValue('CULQI_METHODS_TARJETA'));
            Configuration::updateValue('CULQI_METHODS_BANCAMOVIL', Tools::getValue('CULQI_METHODS_BANCAMOVIL'));
            Configuration::updateValue('CULQI_METHODS_YAPE', Tools::getValue('CULQI_METHODS_YAPE'));
            Configuration::updateValue('CULQI_METHODS_AGENTS', Tools::getValue('CULQI_METHODS_AGENTS'));
            Configuration::updateValue('CULQI_METHODS_WALLETS', Tools::getValue('CULQI_METHODS_WALLETS'));
            Configuration::updateValue('CULQI_METHODS_QUOTEBCP', Tools::getValue('CULQI_METHODS_QUOTEBCP'));
            Configuration::updateValue('CULQI_TIMEXP', Tools::getValue('CULQI_TIMEXP'));
            Configuration::updateValue('CULQI_NOTPAY', Tools::getValue('CULQI_NOTPAY'));
            Configuration::updateValue('CULQI_URL_LOGO', Tools::getValue('CULQI_URL_LOGO'));
            Configuration::updateValue('CULQI_COLOR_PALETTE', Tools::getValue('CULQI_COLOR_PALETTE'));
        }
        $this->_html .= $this->displayConfirmation($this->l('Se actualizaron las configuraciones'));
    }

    public function removeComma($amount) {
        return str_replace(".","",str_replace(',', '', number_format($amount,2,'.',',')));
    }

  }


class CulqiPago
{
    public static $llaveSecreta;
    public static $codigoComercio;
}
