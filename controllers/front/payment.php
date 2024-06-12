<?php

class CulqiPaymentModuleFrontController extends ModuleFrontController
{

    public $ssl = true;
    public $display_column_left = false;
    public $display_column_right = false;

    /**
     * @see FrontController::initContent()
     */
    public function initContent()
    {

        parent::initContent();

        $urlapi_ordercharges = URLAPI_ORDERCHARGES_INTEG;
        $urlapi_checkout = URLAPI_CHECKOUT_INTEG;
        $urlapi_3ds = URLAPI_INTEG_3DS;

        if(Configuration::get('CULQI_ENVIROMENT')=='prod'){
            $urlapi_ordercharges = URLAPI_ORDERCHARGES_PROD;
            $urlapi_checkout = URLAPI_CHECKOUT_PROD;
            $urlapi_3ds = URLAPI_PROD_3DS;
        }
        $version = time();

        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/views/css/global.css');
        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/views/css/culqi.css');
        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/views/css/brands.css');
        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/views/css/waitMe.min.css');
        $this->context->controller->addJS($urlapi_checkout);
        $this->context->controller->addJS('https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js');
        
        $cart = $this->context->cart;
        $address = Db::getInstance()->ExecuteS("SELECT * FROM " . _DB_PREFIX_ . "address where id_address=" . $cart->id_address_invoice);

        if (!$this->module->checkCurrency($cart))
        {
            Tools::redirect('index.php?controller=order');
        }

        $total = Tools::ps_round($cart->getOrderTotal(true, Cart::BOTH),  _PS_PRICE_DISPLAY_PRECISION_);
        $color_palette = Configuration::get('CULQI_COLOR_PALETTE');
        if(!$color_palette) {
            $color_palette = "-";
        }
        $base_url = Tools::getShopDomainSsl(true, true) . __PS_BASE_URI__ . 'module/culqi/payment';

        $total = $total*100;


        $this->context->smarty->assign(array(
            'nbProducts' => $cart->nbProducts(),
            'cust_currency' => $cart->id_currency,
            'currencies' => $this->module->getCurrency((int)$cart->id_currency),
            'total' => $total,
            'totalShow' => $cart->getOrderTotal(true, Cart::BOTH),
            'isoCode' => $this->context->language->iso_code,
            'this_path' => $this->module->getPathUri(),
            'this_path_ssl' => Tools::getShopDomainSsl(true, true) . __PS_BASE_URI__ . 'modules/' . $this->module->name . '/'
        ));

        $this->context->smarty->assign('shop_name', $this->context->shop->name);
        $this->context->smarty->assign('descripcion', "Orden de compra ".$cart->id);
        $this->context->smarty->assign('orden', $cart->id);
        $this->context->smarty->assign('currency', $this->context->currency->iso_code);
        $this->context->smarty->assign('codigo_comercio', Configuration::get('CULQI_LLAVE_PUBLICA'));
        $this->context->smarty->assign('multipayment_enable', Configuration::get('CULQI_ENABLED'));
        $this->context->smarty->assign("psversion", array('min' => '1.6', 'max' => _PS_VERSION_)['max']);
        $this->context->smarty->assign("culqipluginversion", 'v'.CULQI_PLUGIN_VERSION);
        $this->context->smarty->assign("module_dir", $this->module->getPathUri());
        $this->context->smarty->assign("descripcion", "Orden de compra ".$cart->id);
        $this->context->smarty->assign("orden", $cart->id);
        $this->context->smarty->assign("enviroment_backend", $urlapi_ordercharges);
        $this->context->smarty->assign("enviroment_fronted", $urlapi_checkout);
        $this->context->smarty->assign("enviroment_3ds", $urlapi_3ds);
        $this->context->smarty->assign("llave_publica", Configuration::get('CULQI_LLAVE_PUBLICA'));
        $this->context->smarty->assign("llave_secreta", Configuration::get('CULQI_LLAVE_SECRETA'));
        $this->context->smarty->assign("tarjeta", Configuration::get('CULQI_METHODS_TARJETA') == 'yes' ? 'true' : 'false');
        $this->context->smarty->assign("banca_movil", Configuration::get('CULQI_METHODS_BANCAMOVIL') == 'yes' ? 'true' : 'false');
        $this->context->smarty->assign("yape", Configuration::get('CULQI_METHODS_YAPE') == 'yes' ? 'true' : 'false');
        $this->context->smarty->assign("billetera", Configuration::get('CULQI_METHODS_WALLETS') == 'yes' ? 'true' : 'false');
        $this->context->smarty->assign("agente", Configuration::get('CULQI_METHODS_AGENTS') == 'yes' ? 'true' : 'false');
        $this->context->smarty->assign("cuetealo", Configuration::get('CULQI_METHODS_QUOTEBCP') == 'yes' ? 'true' : 'false');
        $this->context->smarty->assign("url_logo", Configuration::get('CULQI_URL_LOGO'));
        $this->context->smarty->assign("color_pallete", explode('-', $color_palette));
        $this->context->smarty->assign("currency", $this->context->currency->iso_code);
        $this->context->smarty->assign("address", $address);
        $this->context->smarty->assign("customer", $this->context->customer);
        $this->context->smarty->assign("email", $this->context->customer->email);
        $this->context->smarty->assign("commerce", Configuration::get('PS_SHOP_NAME'));
        $this->context->smarty->assign("rsa_id", Configuration::get('CULQI_RSA_ID'));
        $this->context->smarty->assign("rsa_pk", Configuration::get('CULQI_RSA_PK'));

        $this->context->smarty->assign("BASE_URL", $base_url);

        $this->setTemplate('payment_execution_payme.tpl');
    }

}
