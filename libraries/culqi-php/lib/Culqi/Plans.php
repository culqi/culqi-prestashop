<?php

namespace Culqi;

/**
 * Class Plans
 *
 * @package Culqi
 */
class Plans extends Resource {

    const URL_PLANS = '/plans/';

    /**
     * @param array|null $options
     *
     * @return all Plans.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function all($options) {
        return $this->request('GET', self::URL_PLANS, $api_key = $this->culqi->api_key, $options);
    }

    /**
     * @param array|null $options
     *
     * @return create Plan response.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function create($options = NULL) {
        return $this->request('POST', self::URL_PLANS, $api_key = $this->culqi->api_key, $options);
    }

    /**
     * @param string|null $id
     *
     * @return get a Plan.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function get($id) {
        return $this->request('GET', self::URL_PLANS . $id . '/', $api_key = $this->culqi->api_key);
    }

    /**
     * @param string|null $id
     *
     * @return delete a Plan.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function delete($id) {
        return $this->request('DELETE', self::URL_PLANS . $id . '/', $api_key = $this->culqi->api_key);
    }

    /**
     * @param string|null $id
     * @param array|null $options
     *
     * @return update Plan response.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
    public function update($id = NULL, $options = NULL) {
        return $this->request('PATCH', self::URL_PLANS . $id . '/', $api_key = $this->culqi->api_key, $options);
    }

}
