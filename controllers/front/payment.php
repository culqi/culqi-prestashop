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

class CulqiPaymentModuleFrontController extends ModuleFrontController
{

    public $ssl = true;
    public $display_column_left = false;
    public $display_column_right = false;

    /**
     * @see FrontController::initContent()
     */
    public function initContent()
    {

        parent::initContent();

        // se agrega js y css necesarios
        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/views/css/culqi.css');
        $this->context->controller->addCSS(__PS_BASE_URI__.'modules/'.$this->module->name.'/views/css/waitMe.min.css');
        $this->context->controller->addJS('https://checkout.culqi.com/plugins/v2/');
        $this->context->controller->addJS('https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js');

        $cart = $this->context->cart;

        if (!$this->module->checkCurrency($cart))
        {
            Tools::redirect('index.php?controller=order');
        }

        $this->context->smarty->assign(array(
            'cart' => $cart,
            'nbProducts' => $cart->nbProducts(),
            'cust_currency' => $cart->id_currency,
            'currencies' => $this->module->getCurrency((int)$cart->id_currency),
            'total' => floatval($cart->getOrderTotal(true, Cart::BOTH))*100,
            'isoCode' => $this->context->language->iso_code,
            'this_path' => $this->module->getPathUri(),
            'this_path_ssl' => Tools::getShopDomainSsl(true, true) . __PS_BASE_URI__ . 'modules/' . $this->module->name . '/'
        ));

        $this->context->smarty->assign('descripcion', "Orden de compra ".$cart->id);
        $this->context->smarty->assign('orden', $cart->id);
        $this->context->smarty->assign('codigo_comercio', Configuration::get('CULQI_CODIGO_COMERCIO'));
        $this->context->smarty->assign('currency', $this->context->currency);

        $this->setTemplate('payment_execution.tpl');
    }

}
