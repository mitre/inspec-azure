# frozen_string_literal: true

require 'ostruct'
require 'json'
require 'active_support/core_ext/hash'

module Azure
  class TableService < Azure::StorageService
    def initialize(resource_group_name, storage_account_name, backend)
      super(resource_group_name, storage_account_name, "table", backend)
    end

    def tables
      expect_array(request("GET", "/Tables", {}, @api_version, expected: 200)&.feed&.entry&.content&.properties)
    end

    def table_policies(name)
      expect_array(request("GET", "/#{name}", { "comp" => "acl" }, @api_version, expected: 200))
    end

    def properties
      request("GET", "/", { "restype" => "service", "comp" => "properties" }, @api_version, expected: 200)&.storage_service_properties
    end

  end
end
