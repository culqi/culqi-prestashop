<?php

class CulqiPostpendingpaymentModuleFrontController extends ModuleFrontController
{	

    public function initContent()
    {
        parent::initContent();
        $this->ajax = false;

        $cart = $this->context->cart;
        $customer = new Customer($cart->id_customer);

        if(!Configuration::get(Tools::getValue('validation'))) die($this->l('Primero, debes pagar la order...'));
        if(Configuration::get(Tools::getValue('validation')) !== 'generatedCulqi') die($this->l('Primero, debes pagar la orden... '));
        Configuration::deleteByName(Tools::getValue('validation'));
        $this->module->validateOrder((int)$cart->id, Configuration::get('CULQI_STATE_PENDING'), (float)$cart->getordertotal(true), 'Culqi', null, array(), (int)$cart->id_currency, false, $customer->secure_key);
        Tools::redirect('index.php?controller=order-confirmation&id_cart=' . (int)$cart->id . '&id_module=' . (int)$this->module->id . '&id_order=' . $this->module->currentOrder . '&key=' . $customer->secure_key);

    }

}