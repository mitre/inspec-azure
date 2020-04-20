# frozen_string_literal: true

require 'ostruct'
require 'json'
require 'active_support/core_ext/hash'

module Azure
  class BlobService < Azure::StorageService
    def initialize(resource_group_name, storage_account_name, backend)
      super(resource_group_name, storage_account_name, "blob", backend)
    end

    def containers
      expect_array(request("GET", "/", { "comp" => "list" }, @api_version, expected: 200)&.enumeration_results&.containers&.container)
    end

    def container(name)
      request("GET", "/#{name}", { "restype" => "container" }, @api_version, expected: 200, unwrap: parse_headers)
    end

    def container_policies(name)
      expect_array(request("GET", "/#{name}", { "restype" => "container", "comp" => "acl" }, @api_version, expected: 200)&.signed_identifiers&.signed_identifier)
    end

    def properties
      request("GET", "/", { "restype" => "service", "comp" => "properties" }, @api_version, expected: 200)&.storage_service_properties
    end

    private

    def parse_headers
      result = {}
      lambda do |body, _api_version, res|
        to_struct({
          "Last_Modified" => res.headers["last-modified"],
          "Etag" => res.headers["etag"],
          "LeaseStatus" => res.headers["x-ms-lease-status"],
          "LeaseState" => res.headers["x-ms-lease-state"],
          "PublicAccess" => res.headers["x-ms-blob-public-access"],
          "HasImmutabilityPolicy" => res.headers["x-ms-has-immutability-policy"],
          "HasLegalHold" => res.headers["x-ms-has-legal-hold"]
        })
      end
    end

  end
end
