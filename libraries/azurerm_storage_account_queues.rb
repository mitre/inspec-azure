# frozen_string_literal: true

require 'azurerm_resource'

class StorageAccountQueues < AzurermPluralResource
  name 'azurerm_storage_account_queues'
  desc 'Fetches all Queues for an Azure Storage Account'
  example <<-EXAMPLE
    describe azurerm_storage_account_queues(resource_group: 'rg', storage_account_name: 'sa') do
      its('names') { should include('my_queue') }
    end
  EXAMPLE

  FilterTable.create
             .register_column(:names, field: 'name')
             .install_filter_methods_on_resource(self, :table)

  attr_reader :table

  def initialize(resource_group: nil, storage_account_name: nil)
    resp = queue_service(resource_group, storage_account_name).queues
    return if has_error?(resp)

    @table = resp
  end

  def to_s
    'Storage Account Queues'
  end
end
