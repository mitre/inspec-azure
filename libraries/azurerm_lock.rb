# frozen_string_literal: true

require 'azurerm_resource'

class AzurermLock < AzurermPluralResource
  name 'azurerm_lock'
  desc 'Verifies settings for an Azure Lock on a Resource'
  example <<-EXAMPLE
    describe azurerm_locks(resource_group: 'my-rg', resource_name: 'my-vm', resource_type: 'Microsoft.Compute/virtualMachines', name: 'my-lock-name') do
      it { should exist }
    end
  EXAMPLE

  attr_reader(:table,:properties, :id, :type, :name, :level)

  def initialize(resource_group: nil, resource_name: nil, resource_type: nil, name: nil)
    if resource_group.nil? || resource_name.nil? || resource_type.nil? || name.nil?
      return fail_resource 'All parameters must be specified to fetch a specific resource lock.'
    end

    resp = management.lock(resource_group, resource_type, resource_name, name)
    return if has_error?(resp)

    @properties = resp.properties
    @id = resp.id
    @type = resp.type
    @name = resp.name
    @level = resp.properties.level
  end

  def has_lock_level?(level)
    @level == level
  end

  def exist?
    !!@properties
  end

  def to_s
    "Azure Lock: `#{@name}`"
  end
end
