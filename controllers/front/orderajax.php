<?php

class CulqiOrderAjaxModuleFrontController extends ModuleFrontController
{

  public function initContent()
  {
    parent::initContent();
    $this->ajax = true;
  }

  public function displayAjax()
  { 
    error_log('Actualizando orden');
    $result = $this->module->updateOrder( Tools::getValue('order_id')); //$_POST["cart_id"]
    die(Tools::jsonEncode($result));
  }

}
