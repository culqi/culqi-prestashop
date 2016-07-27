<?php
if (!defined('_PS_VERSION_'))
    exit;

define('CULQI_SDK_VERSION', '1.1.0');

class Culqi extends PaymentModule
{

    private $_postErrors = array();

    public function __construct()
    {
        $this->name = 'culqi';
        $this->tab = 'payments_gateways';
        $this->version = '1.0.2';
        $this->controllers = array('payment', 'validation', 'postpayment');
        $this->author = 'Culqi';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = array('min' => '1.5', 'max' => _PS_VERSION_);
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Culqi');
        $this->description = $this->l('Acepta tarjetas de crédito y débito en tu tienda online.');
    }

    public function install()
    {
        $this->createStates();

        return (
            parent::install() &&
            $this->registerHook('payment') &&
            $this->registerHook('paymentReturn') &&
            Configuration::updateValue('CULQI_LLAVE_COMERCIO', '') &&
            Configuration::updateValue('CULQI_CODIGO_COMERCIO', '') &&
            Configuration::updateValue('CULQI_AMBIENTE_JS', '')
        );
    }

    private function getAddress($address) {
        if(empty($address->address1)) {
            return $address->address2;
        } else {
            return $address->address1;
        }
    }

    private function getPhone($address) {
        if(empty($address->phone_mobile)) {
            return $address->phone;
        } else {
            return $address->phone_mobile;
        }
    }

    private function getCustomerId() {
        if ($this->context->customer->isLogged()) {
            return (int) $this->context->customer->id;
        } else {
            return 0;
        }
    }

    public function postPayment($respuestaCliente) {
        CulqiPago::$codigoComercio = Configuration::get('CULQI_CODIGO_COMERCIO');
        CulqiPago::$llaveSecreta = Configuration::get('CULQI_LLAVE_COMERCIO');

        return json_decode(CulqiPago::decifrar($respuestaCliente));
    }

    public function errorPayment($mensaje) {
        $smarty = $this->context->smarty;
        $smarty->assign('culqi_error_pago', $mensaje);
    }

    public function createPrePayment() {
        CulqiPago::$codigoComercio = Configuration::get('CULQI_CODIGO_COMERCIO');
        CulqiPago::$llaveSecreta = Configuration::get('CULQI_LLAVE_COMERCIO');
        CulqiPago::$servidorBase = Configuration::get('CULQI_AMBIENTE_JS');

        $cart = $this->context->cart;
        $smarty = $this->context->smarty;

        $userAddress = new Address(intval($cart->id_address_invoice));
        $userCountry = new Country(intval($userAddress->id_country));
        $userCurrency = new Currency(intval($cart->id_currency));

        try {

            $data = Pago::crearDatospago(array(
                Pago::PARAM_NUM_PEDIDO => rand(5, 10000),
                Pago::PARAM_MONEDA => $userCurrency->iso_code,
                Pago::PARAM_MONTO => $this->removeComma($cart->getOrderTotal(true, Cart::BOTH)),
                Pago::PARAM_DESCRIPCION => "Orden de compra $cart->id",
                Pago::PARAM_COD_PAIS => $userCountry->iso_code,
                Pago::PARAM_CIUDAD => $userAddress->city,
                Pago::PARAM_DIRECCION => $this->getAddress($userAddress),
                Pago::PARAM_NUM_TEL => $this->getPhone($userAddress),
                "correo_electronico" => $this->context->customer->email,
                "id_usuario_comercio" => $this->getCustomerId(),
                "nombres" => $this->context->customer->firstname,
                "apellidos" => $this->context->customer->lastname,                
                "plugin_culqi" => "{'plataforma': 'Prestashop','version': '$this->version'}"
            ));

            if($data["codigo_respuesta"] != "venta_registrada") {
                return $data["mensaje_respuesta"];
            }
            $smarty->assign('ambiente_basepath', Configuration::get('CULQI_AMBIENTE_JS'));
            $smarty->assign('codigo_comercio', Configuration::get('CULQI_CODIGO_COMERCIO'));
            $smarty->assign('informacion_venta', $data[Pago::PARAM_INFO_VENTA]);
            return '';
        } catch (InvalidParamsException $e) {
            echo $e->getMessage()."\n";
        }
    }

    public function hookPayment($params)
    {
        if (!$this->active)
            return;
        if (!$this->checkCurrency($params['cart']))
            return;

        $this->smarty->assign(array(
            'this_path' => $this->_path,
            'this_path_ssl' => Tools::getShopDomainSsl(true, true).__PS_BASE_URI__.'modules/'.$this->name.'/'
        ));
        return $this->display(__FILE__, 'payment.tpl');
    }

    public function hookPaymentReturn($params)
    {
        if (!$this->active)
            return;
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
            foreach ($currencies_module as $currency_module)
                if ($currency_order->id == $currency_module['id_currency'])
                    return true;
        return false;
    }

    public function uninstallStates() {
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
        if (!parent::uninstall()
        || !Configuration::deleteByName('CULQI_STATE_OK')
        || !Configuration::deleteByName('CULQI_STATE_ERROR')
        || !Configuration::deleteByName('CULQI_LLAVE_COMERCIO')
        || !Configuration::deleteByName('CULQI_AMBIENTE_JS')
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
                $this->_postErrors[] = $this->l('El campo llave de comercio es requerido.');

            if (!Tools::getValue('CULQI_AMBIENTE_JS'))
                $this->_postErrors[] = $this->l('El campo ambiente es requerido.');

            if (!Tools::getValue('CULQI_CODIGO_COMERCIO'))
                $this->_postErrors[] = $this->l('El campo código de comercio es requerido.');
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
                $this->_postProcess();
            else
                foreach ($this->_postErrors as $err)
                    $this->_html .= $this->displayError($err);
        }

        $this->_html .= $this->_displayInfo();
        $this->_html .= $this->renderForm();

        return $this->_html;
    }

    private function createStates() {
        if (!Configuration::get('CULQI_STATE_OK'))
        {
            $order_state = new OrderState();
            $order_state->name = array();
            foreach (Language::getLanguages() as $language)
                $order_state->name[$language['id_lang']] = 'Exitoso';
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
            foreach (Language::getLanguages() as $language)
                $order_state->name[$language['id_lang']] = 'Incorrecto';
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

    public function renderForm()
    {
        $entorno_options = array(
            array(
                'id_option' => 'https://integ-pago.culqi.com',
                'name' => 'Integración'
            ), array(
                'id_option' => 'https://pago.culqi.com',
                'name' => 'Producción'
            )
        );

        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('CONFIGURACIONES GENERALES'),
                    'icon' => 'icon-money'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('Llave del comercio'),
                        'name' => 'CULQI_LLAVE_COMERCIO',
                        'required' => true
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->l('Entorno'),
                        'name' => 'CULQI_AMBIENTE_JS',
                        'required' => true,
                        'options' => array(
                            'query' => $entorno_options,
                            'id' => 'id_option',
                            'name' => 'name'
                        )
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Código de comercio'),
                        'name' => 'CULQI_CODIGO_COMERCIO',
                        'required' => true
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
            'CULQI_AMBIENTE_JS' => Tools::getValue('CULQI_AMBIENTE_JS', Configuration::get('CULQI_AMBIENTE_JS')),
            'CULQI_CODIGO_COMERCIO' => Tools::getValue('CULQI_CODIGO_COMERCIO', Configuration::get('CULQI_CODIGO_COMERCIO'))
        );
    }

    private function _postProcess()
    {
        if (Tools::isSubmit('btnSubmit'))
        {
            Configuration::updateValue('CULQI_LLAVE_COMERCIO', Tools::getValue('CULQI_LLAVE_COMERCIO'));
            Configuration::updateValue('CULQI_AMBIENTE_JS', Tools::getValue('CULQI_AMBIENTE_JS'));
            Configuration::updateValue('CULQI_CODIGO_COMERCIO', Tools::getValue('CULQI_CODIGO_COMERCIO'));
        }
        $this->_html .= $this->displayConfirmation($this->l('Se actualizaron las configuraciones'));
    }

    public function removeComma($amount) {
        return str_replace(".","",str_replace( ',', '', number_format($amount,2,'.',',')));
    }

    }

class UrlAESCipher
{
    protected $key;
    protected $cipher = MCRYPT_RIJNDAEL_128;
    protected $mode = MCRYPT_MODE_CBC;

    function __construct($spec63bf = null)
    {
        $this->setBase64Key($spec63bf);
    }

    public function setBase64Key($spec63bf)
    {
        $this->key = base64_decode($spec63bf);
    }

    private function sp42f8e2()
    {
        if ($this->key != null) {
            return true;
        } else {
            return false;
        }
    }

    private function sp4b5aaf()
    {
        return mcrypt_create_iv(16, MCRYPT_RAND);
    }

    public function urlBase64Encrypt($sp755f74)
    {
        if ($this->sp42f8e2()) {
            $sp6bc36d = mcrypt_get_block_size($this->cipher, $this->mode);
            $sp810031 = UrlAESCipher::pkcs5_pad($sp755f74, $sp6bc36d);
            $sp1c42c6 = $this->sp4b5aaf();
            return trim(UrlAESCipher::base64_encode_url($sp1c42c6 . mcrypt_encrypt($this->cipher, $this->key, $sp810031, $this->mode, $sp1c42c6)));
        } else {
            throw new Exception('Invlid params!');
        }
    }

    public function urlBase64Decrypt($sp755f74)
    {
        if ($this->sp42f8e2()) {
            $spcc5dfb = UrlAESCipher::base64_decode_url($sp755f74);
            $sp1c42c6 = substr($spcc5dfb, 0, 16);
            $sp20ef79 = substr($spcc5dfb, 16);
            return trim(UrlAESCipher::pkcs5_unpad(mcrypt_decrypt($this->cipher, $this->key, $sp20ef79, $this->mode, $sp1c42c6)));
        } else {
            throw new Exception('Invlid params!');
        }
    }

    public static function pkcs5_pad($sp2dbdda, $sp6bc36d)
    {
        $spf187c8 = $sp6bc36d - strlen($sp2dbdda) % $sp6bc36d;
        return $sp2dbdda . str_repeat(chr($spf187c8), $spf187c8);
    }

    public static function pkcs5_unpad($sp2dbdda)
    {
        $spf187c8 = ord($sp2dbdda[strlen($sp2dbdda) - 1]);
        if ($spf187c8 > strlen($sp2dbdda)) {
            return false;
        }
        if (strspn($sp2dbdda, chr($spf187c8), strlen($sp2dbdda) - $spf187c8) != $spf187c8) {
            return false;
        }
        return substr($sp2dbdda, 0, -1 * $spf187c8);
    }

    protected function base64_encode_url($sp36c362)
    {
        return strtr(base64_encode($sp36c362), '+/', '-_');
    }

    protected function base64_decode_url($sp36c362)
    {
        return base64_decode(strtr($sp36c362, '-_', '+/'));
    }
}

class CulqiPago
{
    public static $llaveSecreta;
    public static $codigoComercio;
    public static $servidorBase = 'https://pago.culqi.com';

    public static function cifrar($sp3231b0)
    {
        $spadece1 = new UrlAESCipher();
        $spadece1->setBase64Key(CulqiPago::$llaveSecreta);
        return $spadece1->urlBase64Encrypt($sp3231b0);
    }

    public static function decifrar($sp3231b0)
    {
        $spadece1 = new UrlAESCipher();
        $spadece1->setBase64Key(CulqiPago::$llaveSecreta);
        return $spadece1->urlBase64Decrypt($sp3231b0);
    }
}

class Pago
{
    const URL_VALIDACION_AUTORIZACION = '/api/v1/web/crear/';
    const URL_ANULACION = '/api/v1/devolver/';
    const URL_CONSULTA = '/api/v1/consultar/';
    const PARAM_COD_COMERCIO = 'codigo_comercio';
    const PARAM_EXTRA = 'extra';
    const PARAM_SDK_INFO = 'sdk';
    const PARAM_NUM_PEDIDO = 'numero_pedido';
    const PARAM_MONTO = 'monto';
    const PARAM_MONEDA = 'moneda';
    const PARAM_DESCRIPCION = 'descripcion';
    const PARAM_COD_PAIS = 'cod_pais';
    const PARAM_CIUDAD = 'ciudad';
    const PARAM_DIRECCION = 'direccion';
    const PARAM_NUM_TEL = 'num_tel';
    const PARAM_INFO_VENTA = 'informacion_venta';
    const PARAM_TICKET = 'ticket';
    const PARAM_VIGENCIA = 'vigencia';
    const PARAM_CORREO_ELECTRONICO = 'correo_electronico';
    const PARAM_NOMBRES = 'nombres';
    const PARAM_APELLIDOS = 'apellidos';
    const PARAM_ID_USUARIO_COMERCIO = 'id_usuario_comercio';

    private static function getSdkInfo()
    {
        return array('v' => CULQI_SDK_VERSION, 'lng_n' => 'php', 'lng_v' => phpversion(), 'os_n' => PHP_OS, 'os_v' => php_uname());
    }

    public static function crearDatospago($sp821fb9, $sp37cd46 = null)
    {
        Pago::validateParams($sp821fb9);
        $sp327f8d = Pago::getCipherData($sp821fb9, $sp37cd46);
        $spa944fe = array(Pago::PARAM_COD_COMERCIO => CulqiPago::$codigoComercio, Pago::PARAM_INFO_VENTA => $sp327f8d);
        $spd4bb0a = Pago::validateAuth($spa944fe);
        if (!empty($spd4bb0a) && array_key_exists(Pago::PARAM_TICKET, $spd4bb0a)) {
            $spd3ecee = array(Pago::PARAM_COD_COMERCIO => $spd4bb0a[Pago::PARAM_COD_COMERCIO], Pago::PARAM_TICKET => $spd4bb0a[Pago::PARAM_TICKET]);
            $spd4bb0a[Pago::PARAM_INFO_VENTA] = CulqiPago::cifrar(json_encode($spd3ecee));
        }
        return $spd4bb0a;
    }

    public static function consultar($sp517f27)
    {
        $sp327f8d = Pago::getCipherData(array(Pago::PARAM_TICKET => $sp517f27));
        $sp821fb9 = array(Pago::PARAM_COD_COMERCIO => CulqiPago::$codigoComercio, Pago::PARAM_INFO_VENTA => $sp327f8d);
        return Pago::postJson(CulqiPago::$servidorBase . Pago::URL_CONSULTA, $sp821fb9);
    }

    public static function anular($sp517f27)
    {
        $sp327f8d = Pago::getCipherData(array(Pago::PARAM_TICKET => $sp517f27));
        $sp821fb9 = array(Pago::PARAM_COD_COMERCIO => CulqiPago::$codigoComercio, Pago::PARAM_INFO_VENTA => $sp327f8d);
        return Pago::postJson(CulqiPago::$servidorBase . Pago::URL_ANULACION, $sp821fb9);
    }

    private static function getCipherData($sp821fb9, $sp37cd46 = null)
    {
        $sp4c1514 = array_merge(array(Pago::PARAM_COD_COMERCIO => CulqiPago::$codigoComercio), $sp821fb9);
        if (!empty($sp37cd46)) {
            $sp4c1514[Pago::PARAM_EXTRA] = $sp37cd46;
        }
        $sp4c1514[Pago::PARAM_SDK_INFO] = Pago::getSdkInfo();
        $spe828da = json_encode($sp4c1514);
        return CulqiPago::cifrar($spe828da);
    }

    private static function validateAuth($sp821fb9)
    {
        return Pago::postJson(CulqiPago::$servidorBase . Pago::URL_VALIDACION_AUTORIZACION, $sp821fb9);
    }

    private static function validateParams($sp821fb9)
    {
        if (!isset($sp821fb9[Pago::PARAM_MONEDA]) or empty($sp821fb9[Pago::PARAM_MONEDA])) {
            throw new InvalidParamsException('[Error] Debe existir una moneda');
        } else {
            if (strlen(trim($sp821fb9[Pago::PARAM_MONEDA])) != 3) {
                throw new InvalidParamsException('[Error] La moneda debe contener exactamente 3 caracteres.');
            }
        }
        if (!isset($sp821fb9[Pago::PARAM_MONTO]) or empty($sp821fb9[Pago::PARAM_MONTO])) {
            throw new InvalidParamsException('[Error] Debe existir un monto');
        } else {
            if (is_int($sp821fb9[Pago::PARAM_MONTO])) {
                return;
            }
            if (is_numeric($sp821fb9[Pago::PARAM_MONTO])) {
                if (!ctype_digit($sp821fb9[Pago::PARAM_MONTO])) {
                    throw new InvalidParamsException('[Error] El monto debe ser un número entero, no flotante.');
                }
            } else {
                throw new InvalidParamsException('[Error] El monto debe ser un número entero.');
            }
        }
    }

    private static function postJson($sp954ec6, $sp821fb9)
    {
        $sp2523af = array('http' => array('header' => "Content-Type: application/json\r\n" . "User-Agent: php-context\r\n", 'method' => 'POST', 'content' => json_encode($sp821fb9), 'ignore_errors' => true));
        $spc35bfb = stream_context_create($sp2523af);
        $spd4bb0a = file_get_contents($sp954ec6, false, $spc35bfb);
        $spbfb5b7 = CulqiPago::decifrar($spd4bb0a);
        return json_decode($spbfb5b7, true);
    }
}

class InvalidParamsException extends Exception
{
}