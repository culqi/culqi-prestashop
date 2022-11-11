<?php

class CulqiWebHookModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();
        $this->ajax = true;
    }

    public function displayAjax()
    {

        Logger::addLog('Inicio weebhook');

        $postBody = file_get_contents("php://input");
        $headers = getallheaders();
		$headers = $headers['Authorization'];
        $authorization = substr($headers,6);
        $credenciales = base64_decode($authorization);
        $credenciales = explode( ':', $credenciales );
        $username = $credenciales[0];
        $password = $credenciales[1];      
        if(!isset($username) or !isset($password)){
           exit("Error: No Autorizado");
        } 
        $postBody = json_decode($postBody, true);
        $data = json_decode($postBody["data"], true);
        Logger::addLog('$data ' . serialize($data));

        $currencyCode = trim($data['currency_code']);
        $state = trim($data['state']);
        $amount = trim($data['amount']);
        $order_number = trim($data['order_number']);
        $id = trim($data['id']);
        $settings = $this->module->getConfigFieldsValues();
        $username_bd = $settings['CULQI_USERNAME'];
		$password_bd = $settings['CULQI_PASSWORD'];
        if( $username != $username_bd || $password != $password_bd ){
			exit("Error: Crendenciales Incorrectas");
		}
        if (empty($amount)) {
            echo json_encode(['success'=>'false', 'msj'=>'No envió el amount']);
            exit();
        }

        if ($postBody["object"] != 'event')
            return;

        switch ($postBody["type"]) {

            case 'order.status.changed':

                Logger::addLog('entro -> order.status.changed');

                $metadata = $data['metadata'];

                if (empty($metadata)) {
                    exit("Error: Metadata vacia");
                }

                if (empty($id) || empty($order_number) || empty($currencyCode) || empty($state)) {
                    exit("Error: order_id, order_number, currency_code o state vacios");
                }

                $order_id = (int)$metadata["order_id"];

                $state = 'CULQI_STATE_OK';
                $stateRequest = $data["state"];
                Logger::addLog('$state ' . $stateRequest);

                if ($stateRequest == 'expired') {
                    $state = 'CULQI_STATE_EXPIRED';
                }
                if ($stateRequest != 'pending') {
                    $this->updateOrderAndcreateOrderHistoryState($order_id,Configuration::get($state));
                }
                break;

            case 'refund.creation.succeeded':

                Logger::addLog('entro -> refund.creation.succeeded');

                $charge_id = $data["chargeId"];

                if (empty($charge_id)) {
                    exit("Error: No envió el chargeId");
                }

                Logger::addLog('$charge_id_1' . $charge_id);
                Logger::addLog('$charge_id_2' . $data->chargeId);

                $order_payment = Db::getInstance()->ExecuteS("SELECT distinct * FROM " . _DB_PREFIX_ . "order_payment where transaction_id='" . $charge_id . "'");
                $order_reference = $order_payment[0]["order_reference"];

                $findorder = Db::getInstance()->ExecuteS("SELECT distinct * FROM " . _DB_PREFIX_ . "orders where reference='" . $order_reference . "'");
                $id = $findorder[0]['id_order'];

                $state_refund = 7;
                
                $this->updateOrderAndcreateOrderHistoryState($id,$state_refund);
                break;
        }
        echo json_encode(['success'=>'true', 'msj'=>'Operación exitosa']);
    }

    public function updateOrderAndcreateOrderHistoryState($id_order,$id_state){
		$new_history = new OrderHistory();
		$new_history->id_order = (int) $id_order;
		$new_history->id_order_state = (int) $id_state;
		$new_history->add(true);
		$new_history->save();
		$order = new Order($id_order);
		$order->current_state = (int) $id_state;
		$order->update();
	}
}