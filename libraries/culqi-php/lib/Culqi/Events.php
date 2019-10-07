<?php

namespace Culqi;

/**
 * Class Events
 *
 * @package Culqi
 */
class Events extends Resource {

  const URL_EVENTS = '/events/';

    /**
     * @param array|null $options
     *
     * @return all Events.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
  public function all($options = NULL) {
      return $this->request('GET', self::URL_EVENTS, $api_key = $this->culqi->api_key, $options);
  }

    /**
     * @param string|null $id
     *
     * @return get a Event.
     * @throws Error\AuthenticationError
     * @throws Error\InvalidApiKey
     * @throws Error\MethodNotAllowed
     * @throws Error\NotFound
     * @throws Error\UnableToConnect
     * @throws Error\UnhandledError
     */
  public function get($id = NULL) {
      return $this->request('GET', self::URL_EVENTS . $id . '/', $api_key = $this->culqi->api_key);
  }

}
