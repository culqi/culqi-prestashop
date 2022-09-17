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
        $postBody = json_decode($postBody, true);
        $data = json_decode($postBody["data"], true);
        Logger::addLog('$data ' . serialize($data));

        $currencyCode = trim($data['currency_code']);
        $state = trim($data['state']);
        $amount = trim($data['amount']);
        $order_number = trim($data['order_number']);
        $id = trim($data['id']);
        //$cartID = $metadata['cart_id'];

        //error_log($cartID);

        if (empty($amount)) {
            echo json_encode(['success'=>'false', 'msj'=>'No envió el amount']);
            exit();
        }

        //if ($ObjCart->orderExists() > 0 ) {
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

                //$metadata = $data["metadata"];

                $order_id = (int)$metadata["pts_order_id"];

                $findorder = Db::getInstance()->ExecuteS("SELECT * FROM " . _DB_PREFIX_ . "orders where id_cart='" . $order_id . "'");

                $id = $findorder[0]['id_order'];
                Logger::addLog('$id ' . $id);

                $state = 'CULQI_STATE_OK';
                $stateRequest = $data["state"];
                Logger::addLog('$state ' . $stateRequest);

                if ($stateRequest == 'expired') {
                    $state = 'CULQI_STATE_EXPIRED';
                }
                if ($stateRequest != 'pending') {
                    updateOrderAndcreateOrderHistoryState($id,Configuration::get($state));
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
                
                updateOrderAndcreateOrderHistoryState($id,$state_refund);
                break;
        }
        //}
        echo json_encode(['success'=>'true', 'msj'=>'Operación exitosa']);
    }

    public function updateOrderAndcreateOrderHistoryState($id_order,$id_state){
		//insertamos el historial
		$new_history = new OrderHistory();
		$new_history->id_order = (int) $id_order;
		$new_history->id_order_state = (int) $id_state;
		$new_history->add(true);
		$new_history->save();
		//actualizamos el estado de la orden
		$order = new Order($id_order);
		$order->current_state = (int) $id_state;
		$order->update();
	}
}