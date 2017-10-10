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

$sql = array();

$sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'culqi_log` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `id_cart` int(9) NOT NULL,
    `id_customer` int(9) NOT NULL,
    `amount` varchar(6),
    `object` varchar(20),
    `currency_code` varchar(3),
    `description` varchar(100),
    `duplicated` varchar(20),
    `outcome_code` varchar(20),
    `outcome_type` varchar(30),
    `outcome_message` varchar(200),
    `reference_code` varchar(20),
    `card_number` varchar(20),
    `card_email` varchar(40),
    `card_brand` varchar(10),
    `card_category` varchar(20),
    `card_type` varchar(20),
    `created_at` datetime,
    PRIMARY KEY  (`id`)
) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8';

foreach ($sql as $query) {
    if (Db::getInstance()->execute($query) == false && Db::getInstance()->execute($query)) {
        return false;
    }
}
