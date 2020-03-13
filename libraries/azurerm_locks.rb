# frozen_string_literal: true

require 'azurerm_resource'

class AzurermLocks < AzurermPluralResource
  name 'azurerm_locks'
  desc 'Verifies settings for an Azure Lock on a Resource'
  example <<-EXAMPLE
    describe azurerm_locks(resource_group: 'my-rg', resource_name: 'my-vm', resource_type: 'Microsoft.Compute/virtualMachines') do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:ids,        field: :id)
             .register_column(:names,      field: :name)
             .register_column(:properties, field: :properties)
             .register_column(:levels) { |table| table.properties.map { |ps|  ps.level } }
             .install_filter_methods_on_resource(self, :table)

  RESOURCE_GROUP_REGEX = /resourceGroups\/(.*?)\//
  PROVIDERS_REGEX = /providers\/(.*?\/.*?)\//
  RESOURCE_REGEX = /providers\/.*?\/.*?\/(.*?)$/ 
  def initialize(resource_group: nil, resource_name: nil, resource_type: nil, id: nil)
    if !id.nil?
      resource_group = RESOURCE_GROUP_REGEX.match(id)&.captures&.first
      resource_type = PROVIDERS_REGEX.match(id)&.captures&.first
      resource_name = RESOURCE_REGEX.match(id)&.captures&.first  
    end

    resp = management.locks(resource_group, resource_name, resource_type)
    @resource_group = resource_group
    @resource_name = resource_name
    @resource_type = resource_type

    return if has_error?(resp)

    @table = resp
  end

  def has_lock_level?(level)
    levels.include?(level)
  end

  def to_s
    path = "/"
    path += "resourceGroups/#{@resource_group}" if !@resource_group.nil?
    path += "/providers/#{@resource_type}/#{@resource_name}" if !@resource_group.nil? && !@resource_name.nil? && !@resource_type.nil?
    "#{properties.length} Azure Locks: `#{path}`"
  end
end
