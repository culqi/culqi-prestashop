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

        $cart = $this->context->cart;

        if (!$this->module->checkCurrency($cart))
            Tools::redirect('index.php?controller=order');

        $result = $this->module->createPrePayment();

        if(!empty($result)){
            Tools::redirect('index.php?controller=order&step=3');
        }

        if(isset($_GET['code'])) {
            $error = base64_decode($_GET['code']);
            $this->context->smarty->assign('payment_error', $error);
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

        $this->setTemplate('payment_execution.tpl');
    }
}