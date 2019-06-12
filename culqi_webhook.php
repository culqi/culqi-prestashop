<?php

include_once(dirname(__FILE__).'/../../config/config.inc.php');
include_once(dirname(__FILE__).'/../../init.php');
include_once(_PS_MODULE_DIR_.'culqi/culqi.php');
$cq = new Culqi();
$cq->validationCulqi();
