<?php

class CulqiRegisterSaleModuleFrontController extends ModuleFrontController
{	

    public function initContent()
    {
        parent::initContent();
        $this->ajax = false;

        $cart = $this->context->cart;
        //var_dump($cart); exit(1);
        $customer = new Customer($cart->id_customer);
        //$order_culqi = Tools::getValue("orderid");
        $this->module->validateOrder((int)$cart->id, Configuration::get('CULQI_STATE_PENDING'), (float)$cart->getordertotal(true), 'Culqi', null, array(), (int)$cart->id_currency, false, $customer->secure_key);

        $id_order = Order::getOrderByCartId($this->context->cart->id);
        //var_dump($id_order); exit(1);
        $order = new Order($id_order);
        //var_dump($order->id); exit(1);
        $order_payment_collection = $order->getOrderPaymentCollection();

        $order_payment = $order_payment_collection[0];
        // $order_payment->card_number = Tools::getValue("card_number").'-'.Tools::getValue("chargeid");
        // $order_payment->card_brand = Tools::getValue("card_brand");
        $order_payment->transaction_id = Tools::getValue("order_id");
        $order_payment->update(); 

        die(Tools::jsonEncode($id_order));
        //Tools::redirect('index.php?controller=order-confirmation&id_cart=' . (int)$cart->id . '&id_module=' . (int)$this->module->id . '&id_order=' . $this->module->currentOrder . '&key=' . $customer->secure_key);

    }

}