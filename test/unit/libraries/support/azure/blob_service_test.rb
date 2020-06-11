# parse_headers
require 'train'
require 'train/transports/azure'

require_relative '../../../test_helper'
require_relative '../../../../../libraries/support/azure/blob_service'

describe "blob service" do
    
  let(:transport) { Train::Transports::Azure.new({}) }
  let(:connection) { transport.connection }
  let(:service) { Azure::BlobService.new(nil,nil,connection).send(:parse_headers).call(nil, nil, response) }

  describe "parse_headers" do
    let(:response) do
      Struct.new(:headers).new({
        "last-modified" => "LAST_MODIFIED_TEST",
        "etag" => "ETAG_TEST",
        "x-ms-lease-status" => "LEASE_STATUS_TEST",
        "x-ms-lease-state" => "LEASE_STATE_TEST",
        "x-ms-blob-public-access" => "PUBLIC_ACCESS_TEST",
        "x-ms-has-immutability-policy" => "IMMUTABILITY_POLICY_TEST",
        "x-ms-has-legal-hold" => "LEGAL_HOLD_TEST"
      })
    end

    it "should parse headers" do
      _(service.Last_Modified).must_equal 'LAST_MODIFIED_TEST'
      _(service.Etag).must_equal 'ETAG_TEST'
      _(service.LeaseStatus).must_equal 'LEASE_STATUS_TEST'
      _(service.LeaseState).must_equal 'LEASE_STATE_TEST'
      _(service.PublicAccess).must_equal 'PUBLIC_ACCESS_TEST'
      _(service.HasImmutabilityPolicy).must_equal 'IMMUTABILITY_POLICY_TEST'
      _(service.HasLegalHold).must_equal 'LEGAL_HOLD_TEST'
    end
  end
end
