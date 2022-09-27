<?php

require_once(dirname(__FILE__, 3) . '/libraries/PrestaShopWebservice/PSWebServiceLibrary.php');

include_once dirname(__FILE__, 3) . '/culqi.php';

class CulqiMerchantAjaxModuleFrontController extends ModuleFrontController
{

    public function initContent()
    {
        parent::initContent();
        $this->ajax = true;
    }

    public function displayAjax()
    {

        $token = $_GET['token'];
        $url_get_merchant = $_GET['url_merchant'];
        $public_key = $_GET['public_key'];

        $url_get_merchant_info = $url_get_merchant . $public_key;

        $data = [
            'merchant' => $public_key,
        ];


        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url_get_merchant_info);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $headers = [
            'Content-Type: application/json',
            'Accept: application/json',
            'Authorization: Bearer ' . $token
        ];

        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $server_output = curl_exec($ch);

        curl_close($ch);

        if ($server_output === false) {
            var_dump(curl_error($ch));
            exit(1);
            throw new Exception(curl_error($ch), curl_errno($ch));
        } else {
            var_dump($server_output);
            exit(1);
        }


        $options = array(
            'http' => array(
                'method' => "GET",
                'header' => array(
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json',
                    'Authorization' => 'Bearer ' . $token
                ),
                'timeout' => 120,
                'body' => ''
            )
        );

        $context = stream_context_create($options);
        $data = file_get_contents($url_get_merchant_info, false, $context);

        var_dump($data);
        exit(1);
        $args = array(
            'method' => 'GET',
            'headers' => array(
                'Content-Type' => 'application/json',
                'Accept' => 'application/json',
                'Authorization' => 'Bearer ' . $token
            ),
            'timeout' => 120,
            'body' => ''
        );
        $webService = new PrestaShopWebservice($url_get_merchant_info, $args, false);
        $xml = $webService->get(['resource' => 'customer']);
        var_dump($xml);
        exit(1);
    }

}
