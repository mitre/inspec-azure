# frozen_string_literal: true

require 'ostruct'
require 'json'
require 'active_support/core_ext/hash'

module Azure
  class StorageService
    include Service

    attr_reader :backend
    
    def initialize(resource_group_name, storage_account_name, storage_type, backend)
      @api_version = ENV["AZURE_CLOUD_STORAGE_API_VERSION"] || "2017-11-09"
      @resource_group_name = resource_group_name
      @storage_account_name = storage_account_name
      @backend = backend
      @storage_type = storage_type

      @storage_suffix = ".#{storage_type}#{@backend.active_cloud.storage_endpoint_suffix}"
    end

    def key
      @key ||= Azure::Management.instance.with_backend(@backend).storage_account_keys(@resource_group_name, @storage_account_name)&.[](0)&.[](0).value
    end

    # private

    def connection
      # create faraday conction object (this is like the conection method in inspec-azure/libraries/support/azure/rest.rb)
      Faraday.new do |conn|
        conn.request  :multipart
        conn.request  :json
        conn.request  :retry,
                      max:                 2,
                      interval:            0.05,
                      interval_randomness: 0.5,
                      backoff_factor:      2,
                      exceptions:          ['Timeout::Error']
        conn.response :json, content_type: /\bjson$/
        conn.adapter  Faraday.default_adapter
      end
    end
    
    def getGMTDate
      # you need to create the date for the header in GMT+0 (this is the same as utc but the header needs the GMT timezone in it)
      date = Time.now.getutc.strftime("%a, %d %b %Y %H:%M:%S")
      "#{date} GMT"
    end


    def getCanonicalizedHeaders(headers)
      canonicalized_headers = ""
    
      # select all headers that begin with 'x-ms-'
      headers = headers.select { |key,value| key.start_with?(/^x-ms-/) }.sort
    
      # create the canonicalized headers string
      headers.each do |key, value|
        canonicalized_headers += "#{key}:#{value.strip.gsub(/\r\n/, "")}\n"
      end
      canonicalized_headers
    end
    
    def getBlobQueueCanonicalizedResource(uri, params, storage_account_name)
      # get just the path from the full uri
      canonicalized_path = URI(uri).path
    
      # make sure sure the canonicalized_path will start with a '/'
      canonicalized_path = "/" + canonicalized_path if !canonicalized_path.start_with?("/")
    
      canonicalized_params = ""
      params.sort.each do |key,value|
        canonicalized_params += "\n#{key}:#{value}"
      end
    
      # create canonicalized resource string
      canonicalized_resource = "/"
      canonicalized_resource += storage_account_name
      canonicalized_resource += canonicalized_path
      canonicalized_resource += canonicalized_params
    end

    def getTableCanonicalizedResource(uri, params, storage_account_name)
      # get just the path from the full uri
      canonicalized_path = URI(uri).path
    
      # make sure sure the canonicalized_path will start with a '/'
      canonicalized_path = "/" + canonicalized_path if !canonicalized_path.start_with?("/")
    
      canonicalized_params = []
      params.select { |key, value| key == "comp" }.sort.each do |key,value|
        canonicalized_params.append "#{key}=#{value}"
      end
    
      # create canonicalized resource string
      canonicalized_resource = "/"
      canonicalized_resource += storage_account_name
      canonicalized_resource += canonicalized_path
      canonicalized_resource += "?#{canonicalized_params.join("&")}" if !canonicalized_params.empty?
      canonicalized_resource
    end
    
    QUEUE_BLOB_AUTH_HEADER_TEMPLATE = "%<method>s\n%<content_encoding>s\n%<content_language>s\n%<content_length>s\n%<content_md5>s\n%<content_type>s\n%<date>s\n%<if_modified_since>s\n%<if_match>s\n%<if_none_match>s\n%<if_unmodified_since>s\n%<range>s\n%<canonicalized_headers>s%<canonicalized_resource>s"
    TABLE_AUTH_HEADER_TEMPLATE = "%<method>s\n%<content_md5>s\n%<content_type>s\n%<date>s\n%<canonicalized_resource>s"
    def getAuthenticationHeader(method, path, params, headers, storage_suffix, storage_account_name, storage_account_key)
      # compute full path without query parameters
      uri = "https://#{storage_account_name}#{storage_suffix}#{path}"
    
      Inspec::Log.debug "Generating Auth Header for service: #{@storage_type}"

      # determine correct template
      if @storage_type.downcase == "blob" || @storage_type.downcase == "queue"
        template = QUEUE_BLOB_AUTH_HEADER_TEMPLATE
        date = ""
        canonicalized_resource = getBlobQueueCanonicalizedResource(uri, params, storage_account_name)
      elsif @storage_type.downcase == "table"
        template = TABLE_AUTH_HEADER_TEMPLATE
        date = headers["x-ms-date"]
        canonicalized_resource = getTableCanonicalizedResource(uri, params, storage_account_name)
      else
        raise Inspec::Exceptions::ResourceFailed, "Cannot generate storage service authentication header for unknown storage serve `#{@storage_type}. Allowed storage services are queue, table, blob."
      end

      # create string to sign
      auth_header_value = template % {
        method: method,
        content_encoding: "",
        content_language: "",
        content_length: "",
        content_md5: "",
        content_type: headers["Content-Type"] || "",
        date: date,
        if_modified_since: "",
        if_match: "",
        if_none_match: "",
        if_unmodified_since: "",
        range: "",
        canonicalized_headers: getCanonicalizedHeaders(headers),
        canonicalized_resource: canonicalized_resource
      }

      Inspec::Log.debug "Header to sign: #{auth_header_value}"
    
      # decode key
      decoded_key = Base64.decode64(storage_account_key)
    
      # create signature
      signature = OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha256'), decoded_key, auth_header_value)
      
      # base64 encode signature
      encoded_signature = Base64.encode64(signature).strip()
    
      # create the actual authorization header value
      "SharedKey #{storage_account_name}:#{encoded_signature}"
    end

    def expect_array(data)
      return [] if data.nil?
      return [data] if !data.is_a?(Array)
      data
    end

    def request(method, path, params, api_version, unwrap: self.from_xml, expected: nil)
      # compute full url
      url = "https://#{@storage_account_name}#{@storage_suffix}#{path}"
  
      # create headers
      headers = {
        "x-ms-version" => api_version,
        "x-ms-date" =>  getGMTDate
      }
    
      # compute auth header
      auth_header = getAuthenticationHeader(method, path, params, headers, @storage_suffix, @storage_account_name, key)
    
      Inspec::Log.debug "Generated Auth Header: #{auth_header}"

      # add auth header
      headers["Authorization"] = auth_header

      # GET request
      if method.downcase == "get"
        connection_method = connection.method(:get)
      # POST request
      elsif method.downcase == "post"
        connection_method = connection.method(:post)
      else
        raise Inspec::Exceptions::ResourceFailed, "Cannot make request to stroage account using unsupported method `#{method}`. Supported methods are GET and POST"
      end

      Inspec::Log.debug "Sending #{method} request to #{url} with parameters #{params}"

      # send actual request to storage account
      res = connection_method.call do |req|
        req.url url
        req.headers = req.headers.merge(headers)
        req.params = req.params.merge(params)
    
        req
      end

      Inspec::Log.debug "Retrieved response with status #{res.status}:\n#{res.body}"

      body = to_struct(unwrap.call(res.body, api_version, res))

      if !expected.nil? && res.status != expected
        raise Inspec::Exceptions::ResourceFailed, "Failed to execute request. Expected status #{expected} but got #{res.status}.\n#{body}"
      end

      body
    end

    def parse_response
      
    end

    def from_xml
      result = {}
      lambda do |body, _api_version, res|
        # API returns XML.
        body = Hash.from_xml(body) unless body.is_a?(Hash)

        # Snake case recursively.
        body.each do |k, v|
          if v.is_a?(Hash)
            result[k.underscore] = from_xml.call(v, nil, nil)
          else
            result[k.underscore] = v
          end
        end
        result
      end
    end

    def catch_404
      yield # yield
    rescue ::Faraday::ConnectionFailed
      # No such Queue.
      # Not all Storage Accounts have a Queue.
      nil
    end
  end
end
