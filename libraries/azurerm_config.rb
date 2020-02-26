# frozen_string_literal: true

require 'support/azure'

class AzurermConfig < AzurermResource
  name 'azurerm_config'
  desc 'Base class to set azure rest api configurations.'
  supports platform: 'azure'

  def initialize
  end

  def set_api_profile(profile)
    management.with_api_profile(profile)
    graph.with_api_profile(profile)
    vault.with_api_profile(profile)
    queue.with_api_profile(profile)
  end

  def set_api_version(version)
    management.with_api_version(version)
    graph.with_api_profile(profile)
    vault.with_api_profile(profile)
    queue.with_api_profile(profile)
  end
end