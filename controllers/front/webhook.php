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
        $metadata = $data['metadata'];
        $cartID = $metadata['cart_id'];

        error_log($cartID);

        if (empty($metadata)) {
            exit("Error: Metadata vacia");
        }

        if (empty($amount) || empty($currencyCode) || empty($state)) {
            exit("Error: valores de la orden incorrectos");
        }

        if(Tools::strlen($cartID) < 1){
            exit("Error: Valores personalizados incorrectos");
        }

        if (Validate::isLoadedObject(new Cart($cartID))) {
            $ObjCart = new Cart($cartID);
        } else {
            exit("Error: El carrito no existe");
        }

        if ($ObjCart->orderExists() > 0 ) {
            if ($postBody["object"] != 'event')
                return;

            switch ($postBody["type"]) {

                case 'order.status.changed':

                    Logger::addLog('entro -> order.status.changed');

                    $metadata = $data["metadata"];

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
                        $order = new Order($id);
                        $order->current_state = (int)Configuration::get($state);
                        $order->update();
                    }

                    break;

                case 'refund.creation.succeeded':

                    Logger::addLog('entro -> refund.creation.succeeded');
                    $charge_id = $data["chargeId"];
                    Logger::addLog('$charge_id_1' . $charge_id);
                    Logger::addLog('$charge_id_2' . $data->chargeId);

                    $order_payment = Db::getInstance()->ExecuteS("SELECT distinct * FROM " . _DB_PREFIX_ . "order_payment where transaction_id='" . $charge_id . "'");
                    $order_reference = $order_payment[0]["order_reference"];

                    $findorder = Db::getInstance()->ExecuteS("SELECT distinct * FROM " . _DB_PREFIX_ . "orders where reference='" . $order_reference . "'");
                    $id = $findorder[0]['id_order'];

                    $state_refund = 7;
                    $order = new Order($id);
                    $order->current_state = (int)$state_refund;
                    $order->update();
                    break;
            }
        }
    }
}