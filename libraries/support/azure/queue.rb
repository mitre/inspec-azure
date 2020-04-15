# frozen_string_literal: true

require 'ostruct'
require 'json'
require 'active_support/core_ext/hash'

module Azure
  class Queue
    include Service

    def initialize(resource_group_name, storage_account_name, backend)
      @resource_group_name = resource_group_name
      @storage_account_name = storage_account_name
      @backend = backend
      @required_attrs = []
      @page_link_name = 'nextMarker'
    end

    def key
      Azure::Management.instance.with_backend(@backend).storage_account_keys(@resource_group_name, @storage_account_name)&.[](0)&.[](0).value
    end

    def queues
      catch_404 do
        get(
          url: '?comp=list',
          headers: { 'x-ms-version' => '2017-11-09' },
          api_version: nil,
          unwrap: from_xml,
        )
      end
    end

    def queue_properties
      catch_404 do
        get(
          url: '/?restype=service&comp=properties',
          headers: { 'x-ms-version' => '2017-11-09' },
          api_version: nil,
          unwrap: from_xml,
        ).storage_service_properties
      end
    end

    private

    def from_xml
      result = {}
      lambda do |body, _api_version|
        # API returns XML.
        body = Hash.from_xml(body) unless body.is_a?(Hash)

        # Snake case recursively.
        body.each do |k, v|
          if v.is_a?(Hash)
            result[k.underscore] = from_xml.call(v, nil)
          else
            result[k.underscore] = v
          end
        end
        result
      end
    end

    def catch_404
      yield # yield
    rescue ::Faraday::ConnectionFailed
      # No such Queue.
      # Not all Storage Accounts have a Queue.
      nil
    end
  end
end
