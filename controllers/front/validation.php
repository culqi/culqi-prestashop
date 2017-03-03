<?php

class CulqiValidationModuleFrontController extends ModuleFrontController
{

  public function postProcess() {
    $cart = $this->context->cart;
    $customer = new Customer($cart->id_customer);
    $this->module->validateOrder((int)$cart->id, Configuration::get('CULQI_STATE_OK'), (float)$cart->getordertotal(true), 'Culqi', null, array(), (int)$cart->id_currency, false, $customer->secure_key);
    Tools::redirect('index.php?controller=order-confirmation&id_cart=' . (int)$cart->id . '&id_module=' . (int)$this->module->id . '&id_order=' . $this->module->currentOrder . '&key=' . $customer->secure_key);

  }

    /*public function initContent()
    {
        parent::initContent();
        $this->ajax = true;
    }

    public function displayAjax()
    {
        $respuesta = $this->module->postPayment(Tools::getValue('respuesta'));
        die(Tools::jsonEncode($respuesta));
    }*/

}
