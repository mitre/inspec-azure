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

  class APIProfile
    def initialize(version, mapping)
      @version = version
      @mapping = mapping
    end

    def get_api_version(provider, resource_type)
      if !@mapping.key?(provider.downcase)
        throw Azure::APIVersionError.new(@version, provider, resource_type)
      end

      provider_resources = @mapping[provider.downcase]
      if !provider_resources.key?(resource_type.downcase)
        throw Azure::APIVersionError.new(@version, provider, resource_type)
      end

      return provider_resources[resource_type.downcase]
    end
  end

  AZURE_API_PROFILES = {
    'latest' => Azure::APIProfile.new('2019-07-01', AZURE_REST_PROFILE_2019_07_01_profile),
    '2019-07-01' => Azure::APIProfile.new('2019-07-01', AZURE_REST_PROFILE_2019_07_01_profile),
    '2019-03-01-hybrid' => Azure::APIProfile.new('2019-03-01-hybrid', AZURE_REST_PROFILE_2019_03_01_hybrid),
    '2018-03-01-hybrid' => Azure::APIProfile.new('2018-03-01-hybrid', AZURE_REST_PROFILE_2018_03_01_hybrid),
    '2017-03-09' => Azure::APIProfile.new('2017-03-09', AZURE_REST_PROFILE_2017_03_09_profile)
  }

end