require 'json'

IMPORT_FILE_NAME = "api_profiles.rb"
PROFILE_SELECTOR = "./*.json"
INDENT = "  "

profile_files = Dir[PROFILE_SELECTOR]

import_file = File.open(IMPORT_FILE_NAME, "w")

profile_files.each do |profile_file|  
  # generate profile object
  profile_json = JSON.parse(File.open(profile_file, "r").read)

  # extract name
  name = profile_json["info"]["name"]

  # open file
  file = File.open("#{name}.rb", "w")

  # write description comment
  description = profile_json["info"]["description"]
  file.write description.split("\n").map { |v| "# " + v }.join("\n")
  file.write "\n"

  provider_blocks = []
  for provider in profile_json["resourcemanager"].keys
    provider_block_lines = []

    for api_version in profile_json["resourcemanager"][provider].keys
      resources = profile_json["resourcemanager"][provider][api_version]
      if resources.class == Hash
        resources = resources.keys
      end
      for resource in resources
        if resource.class == Hash
          resource = resource["resourceType"]
        end
        provider_block_lines.append("\"#{resource.downcase}\" => \"#{api_version.downcase}\"")
      end
    end

    # join provider resource lines
    provider_block = "\"#{provider.downcase}\" => {\n#{provider_block_lines.map { |pr| INDENT*3 + pr }.join(",\n")}\n#{INDENT*2}}"
    provider_blocks.append(provider_block)
  end

  # create profile block
  profile_block = <<-CONTENT
module Azure
  AZURE_REST_PROFILE_#{name.gsub("-", "_")} = {
#{provider_blocks.map { |p| INDENT*2 + p }.join(",\n") }
  }
end
CONTENT

  file.write profile_block
  # "MGMT_COMPUTE" => Azure::SDKProfile.new('2016-03-30', {
  #   'disks' => '2017-03-30'
  # }),

  # cleanup
  file.close

  # write require statement to import file
  import_file.write "require 'support/azure/api_profiles/#{name}'\n"
end

# cleanup
import_file.close