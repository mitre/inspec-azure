require 'support/azure/api_profiles/api_profiles'

module Azure
  
  class APIVersionError < StandardError
    attr_reader :active_profile
    attr_reader :resource_type
    attr_reader :provider

    def initialize(active_profile, provider, resource_type)
      @active_profile = active_profile
      @resource_type = resource_type
      @provider = provider

      msg = "Active profile #{active_profile}: Provider #{provider} does not support resource type #{resource_type}"
      super(msg)
    end
  end

  class APIProfileError < StandardError
    attr_reader :profile_name

    def initialize(profile_name)
      @profile_name = profile_name

      msg = "There is currently no implementation for Azure REST API profile #{profile_name}"
      super(msg)
    end
  end  

  class APIProfile
    def self.get_api_version(provider, resource_type, profile: nil, default: nil)
      if !AZURE_API_PROFILES.key?(profile)
        if default.nil?
          throw Azure::APIProfileError.new(profile)
        else
          default
        end
      end

      mapping = AZURE_API_PROFILES[profile]

      if !mapping.key?(provider.downcase)
        if default.nil?
          throw Azure::APIVersionError.new(profile, provider, resource_type)
        else
          default
        end
      end

      provider_resources = mapping[provider.downcase]
      if !provider_resources.key?(resource_type.downcase)
        if default.nil?
          throw Azure::APIVersionError.new(profile, provider, resource_type)
        else
          default
        end
      end

      return provider_resources[resource_type.downcase]
    end
  end

  AZURE_API_PROFILES = {
    'latest' => AZURE_REST_PROFILE_2019_07_01_profile,
    '2019-07-01' => AZURE_REST_PROFILE_2019_07_01_profile,
    '2019-03-01-hybrid' => AZURE_REST_PROFILE_2019_03_01_hybrid,
    '2018-03-01-hybrid' => AZURE_REST_PROFILE_2018_03_01_hybrid,
    '2017-03-09' => AZURE_REST_PROFILE_2017_03_09_profile
  }

end