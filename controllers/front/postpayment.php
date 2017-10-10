<?php
/*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

class CulqiPostpaymentModuleFrontController extends ModuleFrontController
{	
    public function initContent()
    {
        parent::initContent();
        
        $cart = $this->context->cart;
        $customer = new Customer($cart->id_customer);
        
        $this->ajax = false;
        $ps = Configuration::get('PS_OS_CANCELED');
        
        $id_cart = Tools::getValue('id_cart');
        $sql = 'SELECT outcome_code FROM '._DB_PREFIX_.'culqi_log where id_cart = '.$id_cart;
        $code = Db::getInstance()->getValue($sql);
        
        if ($code == 'AUT0000')
            $culqi_status = true;

        if ($culqi_status)
            $ps = Configuration::get('PS_OS_PAYMENT');
        
        $this->module->validateOrder((int)$cart->id, $ps, (float)$cart->getordertotal(true), 'Culqi', null, array(), (int)$cart->id_currency, false, $customer->secure_key);
        Tools::redirect('index.php?controller=order-confirmation&id_cart=' . (int)$cart->id . '&id_module=' . (int)$this->module->id . '&id_order=' . $this->module->currentOrder . '&key=' . $customer->secure_key);
    }
}
