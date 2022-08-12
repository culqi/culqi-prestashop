<?php

include_once dirname(__FILE__, 3) . '/libraries/culqi-php/lib/culqi.php';
include_once dirname(__FILE__, 3) . '/culqi.php';

class CulqiGenerateOrderModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {

        parent::initContent();
        $this->ajax = false;

        //var_dump('hi'); exit(1);
        $culqiPretashop =  new Culqi();
        $infoCheckout = $culqiPretashop->getCulqiInfoCheckout();
        //var_dump($infoCheckout); exit(1);
        $culqi = new Culqi\Culqi(array('api_key' => $infoCheckout['llave_secreta'] ));
        $phone = ($infoCheckout['address'][0]['phone']!='' and !is_null($infoCheckout['address'][0]['phone'])) ? $infoCheckout['address'][0]['phone'] : '999999999';
        $expiration_date = time() + (int)$infoCheckout['tiempo_exp'] * 60 * 60;

        $args_order = array(
             
            'amount' => (int)$infoCheckout['total'],
            'currency_code' => $infoCheckout['currency'],
            //'description' => $infoCheckout['descripcion'],
            'description' => 'Venta desde Plugin Prestashop',
            //'order_number' => (string)$infoCheckout['orden'] . time() + 24 * 60 * 60,
            'order_number' => 'pts-' . time(),
            'client_details' => array(
                'email' => $infoCheckout['customer']->email,
                'first_name' => $infoCheckout['customer']->firstname,
                'last_name' => $infoCheckout['customer']->lastname,
                //'phone_number' => $infoCheckout['address'][0]['phone']
                'phone_number' => $phone
            ),
            //'expiration_date' => time() + 24 * 60 * 60,
            'expiration_date' => $expiration_date,
            'confirm' => false,
            'enviroment' => $infoCheckout['enviroment_backend'],
            'metadata' => ["pts_order_id" => (string)$infoCheckout['orden'], "sponsor" => "prestashop"]
        );

        //var_dump($args_order); exit(1);
        
        $culqi_order = $culqi->Orders->create( $args_order );
        //var_dump($culqi_order); exit(1);
        //echo var_dump($culqi_order);

        die(Tools::jsonEncode($culqi_order->id));
        

    }
}