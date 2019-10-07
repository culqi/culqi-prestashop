<?php

namespace Culqi;

/**
 * Class Orders
 *
 * @package Culqi
 */
class Orders extends Resource {

    const URL_ORDERS = '/orders/';

    /**
     * @param array|null $options
     *
     * @return Get all Orders
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function all($options) {
        return $this->request('GET', self::URL_ORDERS, $api_key = $this->culqi->api_key, $options);
    }

    /**
     * @param array|null $options
     *
     * @return create Order
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function create($options = NULL) {
        return $this->request('POST', self::URL_ORDERS, $api_key = $this->culqi->api_key, $options);
    }


    /**
     * @param null $id
     * @return confirm Order
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function confirm($id = NULL) {
        return $this->request('POST', self::URL_ORDERS . $id . '/confirm/', $api_key = $this->culqi->api_key);
    }

    /**
     * @param string|null $id
     *
     * @return get a Order
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function get($id) {
        return $this->request('GET', self::URL_ORDERS . $id . '/', $api_key = $this->culqi->api_key);
    }

    /**
     * @param string|null $id
     *
     * @return delete a Order
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function delete($id) {
        return $this->request('DELETE', self::URL_ORDERS . $id . '/', $api_key = $this->culqi->api_key);
    }

    /**
     * @param string|null $id
     * @param array|null $options
     *
     * @return update Order
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function update($id = NULL, $options = NULL) {
        return $this->request('PATCH', self::URL_ORDERS . $id . '/', $api_key = $this->culqi->api_key, $options);
    }

}
