<?php

class CulqiValidationModuleFrontController extends ModuleFrontController
{

    public function initContent()
    {
        parent::initContent();
        $this->ajax = true;
    }

    public function displayAjax()
    {
        $respuesta = $this->module->postPayment(Tools::getValue('respuesta'));
        die(Tools::jsonEncode($respuesta));
    }

}
