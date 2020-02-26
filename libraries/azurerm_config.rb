# frozen_string_literal: true

require 'support/azure'

class AzurermConfig < AzurermResource
  name 'azurerm_config'
  desc 'Base class to set azure rest api configurations.'
  supports platform: 'azure'

  def initialize
  end
end