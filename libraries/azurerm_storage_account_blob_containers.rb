# frozen_string_literal: true

require 'azurerm_resource'

class StorageAccountBlobContainers < AzurermPluralResource
  name 'azurerm_storage_account_blob_containers'
  desc 'Fetches all Blob Containers for an Azure Storage Account'
  example <<-EXAMPLE
    describe azurerm_storage_account_blob_containers(resource_group: 'rg', storage_account_name: 'sa') do
      its('names') { should include('my_blob_container') }
    end
  EXAMPLE

  FilterTable.create
             .register_column(:names, field: 'Name')
             .register_column(:last_modified, field: 'Last_Modified')
             .register_column(:etags, field: 'Etag')
             .register_column(:lease_statuses, field: 'LeaseStatus')
             .register_column(:lease_states, field: 'LeaseState')
             .register_column(:public_accesses, field: 'PublicAccess')
             .register_column(:legal_holds, field: 'HasLegalHold')
             .install_filter_methods_on_resource(self, :table)

  attr_reader :table

  def initialize(resource_group: nil, storage_account_name: nil)
    resp = blob_service(resource_group, storage_account_name).containers
    return if has_error?(resp)

    @table = expand("Properties", resp)
  end

  def to_s
    'Storage Account Blob Containers'
  end

  REQUIRED_FIELDS = [:PublicAccess]
  def nil_required(mems, vals)
    REQUIRED_FIELDS.each do |required_field|
      if !mems.include?(required_field)
        mems.append(required_field)
        vals.append(nil)
      end
    end
    [mems, vals]
  end
  
  def expand(key_to_expand, data)
    data.map do |entry|
      mems = entry[key_to_expand].members + entry.members
      vals = entry[key_to_expand].values + entry.values
      mems, vals = nil_required(mems, vals)
      Azure::Response.create(mems, vals)
    end
  end
end
