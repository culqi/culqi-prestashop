<?php

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

include(dirname(__FILE__).'/../../../../config/config.inc.php');
include(dirname(__FILE__).'/../../../../init.php');

$culqi = Module::getInstanceByName('culqi');
$return = array();

if (!$culqi->active)
	Tools::redirect('index.php');

$data = $_POST['data'];
$return['status'] = false;

if(isset($data)) {
    
    $insert = array(
        'id_cart' => $_POST['id_cart'],
        'id_customer' => $_POST['id_customer'],
        'object' => $data['object'],
        'amount' => $data['amount'],
        'currency_code' => $data['currency_code'],
        'description' => $data['description'],
        'duplicated' => $data['duplicated'],
        'outcome_code' => $data['outcome']['code'],
        'outcome_type' => $data['outcome']['type'],
        'outcome_message' => $data['outcome']['merchant_message'],
        'reference_code' => $data['reference_code'],
        'card_number' => $data['source']['card_number'],
        'card_email' => $data['source']['email'],
        'card_brand' => $data['source']['iin']['card_brand'],
        'card_category' => $data['source']['iin']['card_category'],
        'card_type' => $data['source']['iin']['card_type'],
        'created_at' => date("Y-m-d H:i:s"),
    );
    
    if(Db::getInstance()->insert('culqi_log', $insert))
        $return['status'] = true;
    
    $return['data'] = $insert;
    
} else {
    http_response_code(500);
}

echo json_encode($return);