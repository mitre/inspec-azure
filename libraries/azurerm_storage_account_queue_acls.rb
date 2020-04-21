# frozen_string_literal: true

require 'azurerm_resource'

class AzurermStorageAccountQueueAcls < AzurermSingularResource
  name 'azurerm_storage_account_queue_acls'
  desc 'Verifies settings for a Azure Storage Account Queue ACLs'
  example <<-EXAMPLE
    describe azurerm_storage_account_queue_acls(resource_group: 'rg',
                                                    storage_account_name: 'default',
                                                    queue_name: 'logs') do
      it          { should exist }
      its('name') { should eq('logs') }
    end
  EXAMPLE

  attr_reader :table, :name

  FilterTable.create
    .register_column(:names) { |table| table.ids }
    .register_column(:ids, field: 'id')
    .register_column(:permissions, field: 'permission')
    .register_column(:start_times, field: 'start')
    .register_column(:expiration_times, field: 'expiry')
  .install_filter_methods_on_resource(self, :table)

  def initialize(resource_group: nil, storage_account_name: nil, queue_name: nil)
    @resp = queue_service(resource_group, storage_account_name).queue_policies(queue_name)
    return if has_error?(@resp)

    @name = queue_name
    @table = expand(["access_policy", "AccessPolicy"], @resp)

    @exists = true
  end

  def to_s
    "#{name} Storage Account Queue Acls"
  end

  private 

  REQUIRED_FIELDS = [:permission, :expiry, :start]
  def nil_required(mems, vals)
    mems = mems.map { |m| m.downcase }
    REQUIRED_FIELDS.each do |required_field|
      if !mems.include?(required_field)
        mems.append(required_field)
        vals.append(nil)
      end
    end
    [mems, vals]
  end
  
  def expand(keys_to_expand, data)
    data.map do |entry|
      keys_to_expand.each do |key_to_expand|
        if entry.key?(key_to_expand.to_sym)
          mems = entry[key_to_expand].members + entry.members
          vals = entry[key_to_expand].values + entry.values
          mems, vals = nil_required(mems, vals)
          entry = Azure::Response.create(mems, vals)
        end
      end
      entry
    end
  end

end
