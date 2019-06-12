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

        // se agrega js y css necesarios
        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/views/css/culqi.css');
        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/views/css/waitMe.min.css');
        $this->context->controller->addJS('https://checkout.culqi.com/js/v3');
        $this->context->controller->addJS('https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js');

        $cart = $this->context->cart;

        if (!$this->module->checkCurrency($cart))
        {
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

        // Crear una orden   
        if (Configuration::get('CULQI_ENABLED_MULTIPAYMENT')) {
           $order = $this->module->createOrder();     
           // Asignar una orden
           $this->context->smarty->assign('order_id', trim($order->id));  
        }
         
        $this->context->smarty->assign('shop_name', $this->context->shop->name);
        $this->context->smarty->assign('descripcion', "Orden de compra ".$cart->id);
        $this->context->smarty->assign('orden', $cart->id);
        $this->context->smarty->assign('currency', $this->context->currency->iso_code);      

        // Config values
        $this->context->smarty->assign('codigo_comercio', Configuration::get('CULQI_CODIGO_COMERCIO'));
        $this->context->smarty->assign('multipayment_enable', Configuration::get('CULQI_ENABLED_MULTIPAYMENT'));
        $this->setTemplate('payment_execution.tpl');
    }

}
