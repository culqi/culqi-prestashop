<?php
/**
 * CULQI PHP SDK
 *
 * Init, cargamos todos los archivos necesarios
 *
 * @version 1.3.0
 * @package Culqi
 * @copyright Copyright (c) 2015-2017 Culqi
 * @license MIT
 * @license https://opensource.org/licenses/MIT MIT License
 * @link https://developers.culqi.com/ Culqi Developers
 */

// Errors
include_once __DIR__ .'/Culqi/Error/Errors.php';
include_once __DIR__ .'/Culqi/Client.php';
include_once __DIR__ .'/Culqi/Resource.php';

// Culqi API
include_once __DIR__ .'/Culqi/Transfers.php';
include_once __DIR__ .'/Culqi/Cards.php';
include_once __DIR__ .'/Culqi/Events.php';
include_once __DIR__ .'/Culqi/Customers.php';
include_once __DIR__ .'/Culqi/Tokens.php';
include_once __DIR__ .'/Culqi/Charges.php';
include_once __DIR__ .'/Culqi/Refunds.php';
include_once __DIR__ .'/Culqi/Subscriptions.php';
include_once __DIR__ .'/Culqi/Plans.php';
include_once __DIR__ .'/Culqi/Iins.php';
include_once __DIR__ .'/Culqi/Orders.php';
include_once __DIR__ .'/Culqi/Culqi.php';
