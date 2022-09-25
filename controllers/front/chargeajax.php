<?php

include_once dirname(__FILE__, 3) . '/libraries/culqi-php/lib/culqi.php';
include_once dirname(__FILE__, 3) . '/culqi.php';

class CulqiChargeAjaxModuleFrontController extends ModuleFrontController
{

  // OLD

  /* public function initContent()
  {
    parent::initContent();
    $this->ajax = true;
  }

  public function displayAjax()
  {
    $culqiPretashop =  new Culqi();
    $infoCheckout = $culqiPretashop->getCulqiInfoCheckout();

    $culqi = new Culqi\Culqi(array('api_key' => $infoCheckout['llave_secreta'] ));
    try {

      $args_charge = array(
            'amount' => (int)$infoCheckout['total'],
            'currency_code' => $infoCheckout['currency'],
            'email' => Tools::getValue("email"),
            'source_id' => Tools::getValue("token_id"),
            'capture' => false, 'enviroment' => $infoCheckout['enviroment_backend'],
            'antifraud_details' => array('device_finger_print_id'=>Tools::getValue("device"))
      );

      if(Tools::getValue("parameters3DS")!==FALSE){
          $args_charge['authentication_3DS'] = Tools::getValue("parameters3DS");
      }

      $culqi_charge = $culqi->Charges->create( $args_charge );

    } catch(Exception $e){
      die(Tools::jsonEncode($e->getMessage()));
    }

    die(Tools::jsonEncode($culqi_charge));
  } */

  public function initContent()
  {
    parent::initContent();
    $this->ajax = true;
  }

  public function displayAjax()
  {
    $culqiPretashop =  new Culqi();
    $infoCheckout = $culqiPretashop->getCulqiInfoCheckout();
    //var_dump($infoCheckout);
    $amount_cart = $infoCheckout['total'];
    $currency_cart = $infoCheckout['currency'];
    $enviroment_cart = $infoCheckout['enviroment_backend'];
    $address = $infoCheckout['address'];
    $country = $infoCheckout['country'];
    $customer = $infoCheckout['customer'];
    $firstname = $customer->firstname;
    $lastname = $customer->lastname;

    //$order_id = Tools::getValue("ps_order_id");
    //var_dump($infoCheckout); exit(1);
    $culqi = new Culqi\Culqi(array('api_key' => $infoCheckout['llave_secreta'] ));
    
    try {

      //PRIMERO REGISTRAMOS EL PEDIDO EN PRESTASHOP
        $cart = $this->context->cart;
        $customer = new Customer($cart->id_customer);
        //$this->module->validateOrder((int)$cart->id, Configuration::get('CULQI_STATE_PENDING'), (float)$cart->getordertotal(true), 'Culqi', null, array(), (int)$cart->id_currency, false, $customer->secure_key);

        //$order_id = Order::getOrderByCartId($this->context->cart->id);
        
      $antifraud_charges = array();
      if (isset($firstname) and !empty($firstname) and !is_null($firstname) and $firstname != '') {
          $antifraud_charges['first_name'] = $firstname;
      }
      if (isset($lastname) and !empty($lastname) and !is_null($lastname) and $lastname != '') {
          $antifraud_charges['last_name'] = $lastname;
      }
      if (isset($address[0]['address1']) and !empty($address[0]['address1']) and !is_null($address[0]['address1']) and $address[0]['address1'] != '') {
          $antifraud_charges['address'] = $address[0]['address1'];
      }
      if (isset($address[0]['city']) and !empty($address[0]['city']) and !is_null($address[0]['city']) and $address[0]['city'] != '') {
          $antifraud_charges['address_city'] = $address[0]['city'];
      }
      if (isset($country[0]['iso_code']) and !empty($country[0]['iso_code']) and !is_null($country[0]['iso_code']) and $country[0]['iso_code'] != '') {
          $antifraud_charges['country_code'] = $country[0]['iso_code'];
      }
      if (isset($address[0]['phone']) and !empty($address[0]['phone']) and !is_null($address[0]['phone']) and $address[0]['phone'] != '') {
          $antifraud_charges['phone_number'] = $address[0]['phone'];
      }
      $antifraud_charges['device_finger_print_id'] = Tools::getValue("device");

      // ENVIAMOS A GENERAR EL CARGO DE CULQI
      $args_charge = array(
            'amount' => (int)$amount_cart,
            'currency_code' => $currency_cart,
            'email' => Tools::getValue("email"),
            'source_id' => Tools::getValue("token_id"),
            'capture' => true, 
            'enviroment' => $enviroment_cart,
            'antifraud_details' => $antifraud_charges,
            'metadata' => ["order_id" => (string)$cart->id, "sponsor" => "prestashop"],
      );

      if(Tools::getValue("parameters3DS")!==FALSE){
          $args_charge['authentication_3DS'] = Tools::getValue("parameters3DS");
      }
      //var_dump($args_charge); exit(1);
      $culqi_charge = $culqi->Charges->create( $args_charge );
      //var_dump($culqi_charge->action_code); exit(1);

      // if (!$culqi_charge->action_code == 'REVIEW') {

      //   $order = new Order($order_id);
      //   $order_payment_collection = $order->getOrderPaymentCollection();

      //   $order_payment = $order_payment_collection[0];
      //   // $order_payment->card_number = Tools::getValue("card_number").'-'.Tools::getValue("chargeid");
      //   // $order_payment->card_brand = Tools::getValue("card_brand");
      //   $order_payment->transaction_id = $culqi_charge;
      //   $order_payment->update(); 
      // }
      

        //die(Tools::jsonEncode($order->id));

      //$findorder = Db::getInstance()->ExecuteS("SELECT distinct * FROM " . _DB_PREFIX_ . "orders where id_order='". $order_id . "'");
      //$reference = $findorder[0]['reference'];

      
      //Db::getInstance()->ExecuteS("UPDATE SET transaction_id = '" . $culqi_charge . "' FROM ps_order_payment WHERE order_reference = '". $reference . "'");
      //$order_reference = $order_payment[0]["order_reference"];

      // $order = new Order($order_id);
      // $order_payment_collection = $order->getOrderPaymentCollection();
      // $order_payment = $order_payment_collection[0];
      // $order_payment->transaction_id = $culqi_charge;
      // $order_payment->update(); 

    } catch(Exception $e){
      die(Tools::jsonEncode($e->getMessage()));
    }

    die(Tools::jsonEncode($culqi_charge));
  }
  
}
