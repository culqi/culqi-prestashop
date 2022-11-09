<?php

class CulqiPostpaymentpendingModuleFrontController extends ModuleFrontController
{	

    public function initContent()
    {
        parent::initContent();
        $this->ajax = false;
        
        $extra_variables = array();
        $order_id = Tools::getValue("ps_order_id");
        
        $findorder = Db::getInstance()->ExecuteS("SELECT distinct * FROM " . _DB_PREFIX_ . "orders where id_order='". $order_id . "'");
        $cart_id = $findorder[0]['id_cart'];
        $secure_key = $findorder[0]['secure_key'];

        Tools::redirect('index.php?controller=order-confirmation&id_cart=' . (int)$cart_id . '&id_module=' . (int)$this->module->id . '&id_order=' . $order_id . '&key=' . $secure_key);

    }

}