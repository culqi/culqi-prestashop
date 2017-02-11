<?php

class CulqiPaymentModuleFrontController extends ModuleFrontController {

    public $ssl = true;
    public $display_column_left = false;
    public $display_column_right = false;

    /**
     * @see FrontController::initContent()
     */
    public function initContent() {

        parent::initContent();

        // se agrega js y css necesarios
        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/assets/css/culqi.css');
        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/assets/css/waitMe.min.css');
        $this->context->controller->addJS('https://checkout.culqi.com/v2/js');
        $this->context->controller->addJS('https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js');
        $this->context->controller->addJS(__PS_BASE_URI__.'modules/'.$this->module->name.'/assets/js/waitMe.min.js');

        $cart = $this->context->cart;

        if (!$this->module->checkCurrency($cart)) {
          Tools::redirect('index.php?controller=order');
        }

        $this->context->smarty->assign(array(
            'nbProducts' => $cart->nbProducts(),
            'cust_currency' => $cart->id_currency,
            'currencies' => $this->module->getCurrency((int)$cart->id_currency),
            'total' => $cart->getOrderTotal(true, Cart::BOTH),
            'isoCode' => $this->context->language->iso_code,
            'this_path' => $this->module->getPathUri(),
            'this_path_ssl' => Tools::getShopDomainSsl(true, true) . __PS_BASE_URI__ . 'modules/' . $this->module->name . '/'
        ));

        $this->context->smarty->assign('descripcion', "Orden de compra ".$cart->id);
        $this->context->smarty->assign('orden', $cart->id);
        $this->context->smarty->assign('codigo_comercio', Configuration::get('CULQI_CODIGO_COMERCIO'));

        $this->setTemplate('payment_execution.tpl');
    }

}
