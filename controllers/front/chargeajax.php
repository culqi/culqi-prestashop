<?php

class CulqiChargeAjaxModuleFrontController extends ModuleFrontController
{

  public function initContent()
  {
    parent::initContent();
    $this->ajax = true;
  }

  public function displayAjax()
  {
    $result = $this->module->charge(Tools::getValue("token_id"), Tools::getValue("installments")); //$_POST["token_id"], $_POST["installments"]
    die(Tools::jsonEncode($result));
  }

}
