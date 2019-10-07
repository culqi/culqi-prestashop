<?php

namespace Culqi;

/**
 * Class Charges
 *
 * @package Culqi
 */
class Charges extends Resource {

    const URL_CHARGES = '/charges/';

    /**
     * @param array|null $options
     *
     * @return all Charges.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function all($options = NULL) {
        return $this->request('GET', self::URL_CHARGES, $api_key = $this->culqi->api_key, $options);
    }

    /**
     * @param array|null $options
     *
     * @return create Charge response.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function create($options = NULL) {
        return $this->request('POST', self::URL_CHARGES, $api_key = $this->culqi->api_key, $options);
    }

    /**
     * @param string|null $id
     *
     * @return get a Charge.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function get($id = NULL) {
        return $this->request('GET', self::URL_CHARGES . $id . '/', $api_key = $this->culqi->api_key);
    }

    /**
     * @param string|null $id
     *
     * @return get a capture of Charge.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function capture($id = NULL) {
        return $this->request('POST', self::URL_CHARGES . $id . '/capture/', $api_key = $this->culqi->api_key);
    }

    /**
     * @param string|null $id
     * @param array|null $options
     *
     * @return update Charge response.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function update($id = NULL, $options = NULL) {
        return $this->request('PATCH', self::URL_CHARGES . $id . '/', $api_key = $this->culqi->api_key, $options);
    }

}
