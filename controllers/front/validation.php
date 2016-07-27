<?php

class CulqiValidationModuleFrontController extends ModuleFrontController
{

    public function initContent() {
        parent::initContent();
        $this->ajax = true;
    }

    public function displayAjax() {
        $smarty = $this->context->smarty;

        $respuesta = $this->module->postPayment(Tools::getValue('respuesta'));
        $array = json_decode(json_encode($respuesta), true);

        die(Tools::jsonEncode($array));
    }

}