# frozen_string_literal: true

require 'ostruct'
require 'json'
require 'active_support/core_ext/hash'

module Azure
  class QueueService < Azure::StorageService
    def initialize(resource_group_name, storage_account_name, backend)
      super(resource_group_name, storage_account_name, "queue", backend)
    end

    def queues
      expect_array(request("GET", "/", { "comp" => "list" }, @api_version, expected: 200)&.enumeration_results&.queues&.queue)
    end

    def queue_policies(name)
      expect_array(request("GET", "/#{name}", { "restype" => "queue", "comp" => "acl" }, @api_version, expected: 200)&.signed_identifiers&.signed_identifier)
    end

    def properties
      request("GET", "/", { "restype" => "service", "comp" => "properties" }, @api_version, expected: 200).storage_service_properties
    end

  end
end
