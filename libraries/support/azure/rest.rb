# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'inspec/log'

module Azure
  class Rest
    USER_AGENT        = 'User-Agent'
    INSPEC_USER_AGENT = 'pid-18d63047-6cdf-4f34-beed-62f01fc73fc2'

    attr_reader :host, :resource, :credentials

    def initialize(client)
      @host        = client.base_url
      @resource    = client.base_url.to_s
      @resource    += '/' unless @resource.end_with?('/')
      @credentials = client.credentials
    end

    def get(path, params: {}, headers: {})
      add_user_agent!(headers)
      res = connection.get do |req|
        req.url path

        req.params  = req.params.merge(params)
        req.headers = req.headers.merge(headers)
        credentials.sign_request(req)

        Inspec::Log.debug "Sending get request: #{req}"
        req
      end

      Inspec::Log.debug "Got #{res.status} response:\n#{res.body}"
      res
    end

    def post(path, params: {}, headers: {}, body: nil)
      add_user_agent!(headers)
      res = connection.post do |req|
        req.url path
        req.body    = body if body
        req.params  = req.params.merge(params)
        req.headers = req.headers.merge(headers)
        credentials.sign_request(req)

        Inspec::Log.debug "Sending post request: #{req}"
        req
      end

      Inspec::Log.debug "Got #{res.status} response:\n#{res.body}"
      res
    end

    private

    def connection
      @connection ||= Faraday.new(url: host) do |conn|
        conn.request  :multipart
        conn.request  :json
        conn.request  :retry,
                      max:                 2,
                      interval:            0.05,
                      interval_randomness: 0.5,
                      backoff_factor:      2,
                      exceptions:          ['Timeout::Error']
        conn.response :json, content_type: /\bjson$/
        conn.adapter  Faraday.default_adapter
      end

      Inspec::Log.debug "Creating faraday connection object for host `#{host}`"
      @connection
    end

    def authorization_header
      @authentication ||= Authentication.new(
        *credentials.values_at(:tenant_id, :client_id, :client_secret), resource
      )
      @authentication.authentication_header
    end

    def add_user_agent!(headers)
      current_user_agent = headers.fetch(USER_AGENT, nil)
      if current_user_agent.nil?
        headers[USER_AGENT] = INSPEC_USER_AGENT
      else
        headers[USER_AGENT] = current_user_agent + "; #{INSPEC_USER_AGENT}"
      end
    end
  end
end
