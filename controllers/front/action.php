<?php

class ActionModuleFrontController extends ModuleFrontController {
  public function initContent()
  {
    parent::initContent();
    $this->ajax = true;
  }

  public function displayAjax(){
    echo "dfdsfdsf";
  }

}
