# frozen_string_literal: true

require 'azurerm_resource'

class AzurermStorageAccountTableService < AzurermSingularResource
  name 'azurerm_storage_account_table_service'
  desc 'Verifies settings for a Azure Storage Account Table Service'
  example <<-EXAMPLE
    describe azurerm_storage_account_table_service(resource_group: 'rg',
                                                    storage_account_name: 'default') do
      it          { should exist }
      its('name') { should eq('logs') }
    end
  EXAMPLE

  attr_reader :properties, :name

  def initialize(resource_group: nil, storage_account_name: nil)
    @resp = table_service(resource_group, storage_account_name).properties
    return if has_error?(@resp)

    @name = storage_account_name
    @properties = @resp
    
    @exists = true
  end

  def to_s
    "#{name} Storage Account Table Service"
  end

end
