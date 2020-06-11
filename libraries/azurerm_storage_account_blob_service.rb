# frozen_string_literal: true

require 'azurerm_resource'

class AzurermStorageAccountBlobService < AzurermSingularResource
  name 'azurerm_storage_account_blob_service'
  desc 'Verifies settings for a Azure Storage Account Blob Service'
  example <<-EXAMPLE
    describe azurerm_storage_account_blob_service(resource_group: 'rg',
                                                    storage_account_name: 'default') do
      it          { should exist }
      its('name') { should eq('logs') }
    end
  EXAMPLE

  attr_reader :properties, :name

  def initialize(resource_group: nil, storage_account_name: nil)
    @resp = blob_service(resource_group, storage_account_name).properties
    return if has_error?(@resp)

    @name = storage_account_name
    @properties = @resp
    
    @exists = true
  end

  def to_s
    "#{name} Storage Account Blob Service"
  end

end