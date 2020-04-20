# frozen_string_literal: true

require 'azurerm_resource'

class AzurermStorageAccountBlobContainerAcls < AzurermSingularResource
  name 'azurerm_storage_account_blob_container_acls'
  desc 'Verifies settings for a Azure Storage Account Blob Container ACLs'
  example <<-EXAMPLE
    describe azurerm_storage_account_blob_container_acls(resource_group: 'rg',
                                                    storage_account_name: 'default',
                                                    blob_container_name: 'logs') do
      it          { should exist }
      its('name') { should eq('logs') }
    end
  EXAMPLE

  attr_reader :table, :name

  FilterTable.create
    .register_column(:names) { |table| table.ids }
    .register_column(:ids, field: 'Id')
    .register_column(:permissions, field: 'Permission')
    .register_column(:start_times, field: 'Start')
    .register_column(:expiration_times, field: 'Expiry')
  .install_filter_methods_on_resource(self, :table)

  def initialize(resource_group: nil, storage_account_name: nil, blob_container_name: nil)
    @resp = blob_service(resource_group, storage_account_name).container_policies(blob_container_name)
    return if has_error?(@resp)

    @name = blob_container_name
    @table = expand("AccessPolicy", @resp)

    @exists = true
  end

  def to_s
    "#{name} Storage Account Blob Container Acls"
  end

  private 

  REQUIRED_FIELDS = [:Permission, :Expiry, :Start]
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
