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
    const MODULE_AUTHOR = "Team Culqi (Brayan Cruces, Willy Aguirre)";
    const MODULE_NAME_DISP = "Culqi";

    public function __construct()
    {
        $this->name = 'culqi';
        $this->tab = 'payments_gateways';
        $this->version = '2.2.0';
        $this->controllers = array('chargeajax' ,'payment', 'validation', 'postpayment');
        $this->author = 'Team Culqi (Brayan Cruces, Willy Aguirre)';
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
        include(dirname(__FILE__).'/sql/install.php');
        
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

        $cargo = $culqi->Charges->create(
            array(
              "amount" => $this->removeComma($cart->getOrderTotal(true, Cart::BOTH)),
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
              "metadata" => array("order_id"=>(string)$cart->id),
              "email" => $this->context->customer->email,
              "source_id" => $token_id
            )
        );
        return $cargo;
      } catch(Exception $e){
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
        return $this->display(__FILE__, 'payment.tpl');
    }

    public function hookPaymentReturn($params)
    {
        if (!$this->active)
        {
          return;
        }
        $this->smarty->assign(
            array(
                'status' => 'ok'
            )
        );
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
                FROM " . _DB_PREFIX_ . "configuration WHERE name =  'CULQI_STATE_ERROR' )")
        ) return true;
        return false;
    }

    public function uninstall()
    {
        include(dirname(__FILE__).'/sql/uninstall.php');
        
        if (!parent::uninstall()
        || !Configuration::deleteByName('CULQI_STATE_OK')
        || !Configuration::deleteByName('CULQI_STATE_ERROR')
        || !Configuration::deleteByName('CULQI_LLAVE_COMERCIO')
        || !Configuration::deleteByName('CULQI_CODIGO_COMERCIO')
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
                    'title' => $this->l('CONFIGURACIONES GENERALES CULQI'),
                    'icon' => 'icon-money'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('Llave Pública'),
                        'name' => 'CULQI_CODIGO_COMERCIO',
                        'required' => true
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Llave Secreta'),
                        'name' => 'CULQI_LLAVE_COMERCIO',
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
    }

    public function getConfigFieldsValues()
    {
        return array(
            'CULQI_LLAVE_COMERCIO' => Tools::getValue('CULQI_LLAVE_COMERCIO', Configuration::get('CULQI_LLAVE_COMERCIO')),
            'CULQI_CODIGO_COMERCIO' => Tools::getValue('CULQI_CODIGO_COMERCIO', Configuration::get('CULQI_CODIGO_COMERCIO'))
        );
    }

    private function _postProcess()
    {
        if (Tools::isSubmit('btnSubmit'))
        {
            Configuration::updateValue('CULQI_LLAVE_COMERCIO', Tools::getValue('CULQI_LLAVE_COMERCIO'));
            Configuration::updateValue('CULQI_CODIGO_COMERCIO', Tools::getValue('CULQI_CODIGO_COMERCIO'));
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
