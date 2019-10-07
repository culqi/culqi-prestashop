<?php

include_once(__DIR__ .'/../../config/config.inc.php');
include_once(__DIR__ .'/../../init.php');
include_once(_PS_MODULE_DIR_.'culqi/culqi.php');
$cq = new Culqi();
$cq->validationCulqi();
