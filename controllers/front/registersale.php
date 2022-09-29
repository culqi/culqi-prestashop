<?php

include_once dirname(__FILE__, 3) . '/libraries/culqi-php/lib/culqi.php';
include_once dirname(__FILE__, 3) . '/culqi.php';

class CulqiRegisterSaleModuleFrontController extends ModuleFrontController
{	

    public function initContent()
    {
        parent::initContent();
        $this->ajax = false;

        $cart = $this->context->cart;
        $customer = new Customer($cart->id_customer);
        $this->module->validateOrder((int)$cart->id, Configuration::get('CULQI_STATE_PENDING'), (float)$cart->getordertotal(true), 'Culqi', null, array(), (int)$cart->id_currency, false, $customer->secure_key);

        $id_order = Order::getOrderByCartId($this->context->cart->id);
        $order = new Order($id_order);
        $order_payment_collection = $order->getOrderPaymentCollection();

        $order_payment = $order_payment_collection[0];
        $order_payment->transaction_id = Tools::getValue("order_id");
        $order_payment->update();
        $culqiPretashop =  new Culqi();
        $infoCheckout = $culqiPretashop->getCulqiInfoCheckout();
        $enviroment_cart = $infoCheckout['enviroment_backend'];
        $culqi = new Culqi\Culqi(array('api_key' => $infoCheckout['llave_secreta'] ));
        $args_order = array(
            'enviroment' => $enviroment_cart,
            'metadata' => ["order_id" => $id_order, "sponsor" => "prestashop"],
         );

        $culqi_order = $culqi->Orders->update( Tools::getValue("order_id"), $args_order ); 

        die(Tools::jsonEncode($id_order));

    }

}