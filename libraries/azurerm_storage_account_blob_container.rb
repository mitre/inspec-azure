# frozen_string_literal: true

require 'azurerm_resource'

class AzurermStorageAccountBlobContainer < AzurermSingularResource
  name 'azurerm_storage_account_blob_container'
  desc 'Verifies settings for a Azure Storage Account Blob Container'
  example <<-EXAMPLE
    describe azurerm_storage_account_blob_container(resource_group: 'rg',
                                                    storage_account_name: 'default',
                                                    blob_container_name: 'logs') do
      it          { should exist }
      its('name') { should eq('logs') }
    end
  EXAMPLE

  ATTRS = {
    :last_modified => :LastModified,
    :etag => :Etag,
    :lease_status => :LeaseStatus,
    :lease_state => :LeaseState,
    :public_access => :PublicAccess,
    :has_immutability_policy => :HasImmutabilityPolicy,
    :has_legal_hold => :HasLegalHold,
    :name => :Name
  }.freeze

  attr_reader(*(ATTRS.keys))

  def initialize(resource_group: nil, storage_account_name: nil, blob_container_name: nil)
    @resp = blob_service(resource_group, storage_account_name).container(blob_container_name)
    return if has_error?(@resp)

    assign_fields_with_map(ATTRS, @resp)

    @name = blob_container_name

    @exists = true
  end

  def to_s
    "#{name} Storage Account Blob Container"
  end

end
