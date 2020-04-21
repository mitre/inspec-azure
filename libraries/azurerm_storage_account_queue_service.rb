# frozen_string_literal: true

require 'azurerm_resource'

class AzurermStorageAccountQueueService < AzurermSingularResource
  name 'azurerm_storage_account_queue_service'
  desc 'Verifies settings for a Azure Storage Account Queue Service'
  example <<-EXAMPLE
    describe azurerm_storage_account_queue_service(resource_group: 'rg',
                                                    storage_account_name: 'default') do
      it          { should exist }
      its('name') { should eq('logs') }
    end
  EXAMPLE

  attr_reader :properties, :name

  def initialize(resource_group: nil, storage_account_name: nil)
    @resp = queue_service(resource_group, storage_account_name).properties
    return if has_error?(@resp)

    @name = storage_account_name
    @properties = @resp
    
    @exists = true
  end

  def to_s
    "#{name} Storage Account Queue Service"
  end

end
