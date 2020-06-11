# getCanonicalizedHeaders
# getBlobQueueCanonicalizedResource
# getTableCanonicalizedResource
# getAuthenticationHeader
# expect_array
# from_xml

require 'train'
require 'train/transports/azure'

require_relative '../../../test_helper'
require_relative '../../../../../libraries/support/azure/storage_service'

describe "storage service" do
  let(:transport) { Train::Transports::Azure.new({}) }
  let(:connection) { transport.connection }
  let(:service) { Azure::StorageService.new(nil, nil, 'blob', connection) }

  it "fails to initialize unsupported storage type" do
    assert_raises(Azure::StorageService::StorageTypeError) do
      Azure::StorageService.new(nil, nil, 'DOESNT EXIST', connection)
    end
  end

  it "can initial supported storage types" do
    _(Azure::StorageService.new(nil, nil, 'blob', connection).is_a?(Azure::StorageService)).must_equal true
    _(Azure::StorageService.new(nil, nil, 'queue', connection).is_a?(Azure::StorageService)).must_equal true
    _(Azure::StorageService.new(nil, nil, 'table', connection).is_a?(Azure::StorageService)).must_equal true
  end

  describe "getGMTDate" do
    it "should fetch date" do
      _(service.getGMTDate).must_match /\w+,\s+\d+\s+\w+\s+\d+\s+[\d:]+\s+GMT/
    end
  end

  describe "getCanonicalizedHeaders" do
    headers = {
      'x-ms-test-last' => 'TEST_LAST',
      'x-ms-test-first' => 'TEST_FIRST',
      'wont_include' => 'wont_include'
    }
    it "should sort and create canonicalized headers" do
      _(service.getCanonicalizedHeaders(headers)).must_equal "x-ms-test-first:TEST_FIRST\nx-ms-test-last:TEST_LAST\n"
    end
  end

  describe "getBlobQueueCanonicalizedResource" do
    params = {
      'KEY_LAST' => 'TEST_LAST',
      'KEY_FIRST' => 'TEST_FIRST'
    }
    uri = "http://test.domain/test_path"
    sa_name = "STORAGE_ACCOUNT_NAME"

    it "should sort and create canonicalized resource for blob and queue" do
      _(service.getBlobQueueCanonicalizedResource(uri, params, sa_name)).must_equal "/STORAGE_ACCOUNT_NAME/test_path\nKEY_FIRST:TEST_FIRST\nKEY_LAST:TEST_LAST"
    end
  end

  describe "getTableCanonicalizedResource" do
    params = {
      'not_included' => 'TEST',
      'comp' => 'INCLUDED'
    }
    params_no_comp = {
      'not_included' => 'TEST'
    }
    uri = "http://test.domain/test_path"
    sa_name = "STORAGE_ACCOUNT_NAME"

    it "should create canonicalized resource with comp param" do
      _(service.getTableCanonicalizedResource(uri, params, sa_name)).must_equal "/STORAGE_ACCOUNT_NAME/test_path?comp=INCLUDED"
    end

    it "should create canonicalized resource without comp param" do
      _(service.getTableCanonicalizedResource(uri, params_no_comp, sa_name)).must_equal "/STORAGE_ACCOUNT_NAME/test_path"
    end
  end

  describe "getAuthenticationHeader" do
    method = 'POST'
    path = '/test'
    params = {
      'not_included' => 'TEST',
      'comp' => 'INCLUDED'
    }
    headers = {
      'x-ms-test-last' => 'TEST_LAST',
      'x-ms-test-first' => 'TEST_FIRST',
      'wont_include' => 'wont_include'
    }
    storage_suffix = 'mycloud.azurestack.org'
    storage_account_name = 'mystorageaccount'
    storage_account_key = 'mystorageaccountkey'

    expected_header_blob = "SharedKey mystorageaccount:UGAz4rvr4vrLe5FdRgefoUj4MyvOA30BhdASpBB4wpk="
    expected_header_table = "SharedKey mystorageaccount:UGAz4rvr4vrLe5FdRgefoUj4MyvOA30BhdASpBB4wpk="

    it "should create header blob/queue" do
      service.instance_variable_set(:@storage_type, 'blob')
      _(service.getAuthenticationHeader(method, path, params, headers, storage_suffix, storage_account_name, storage_account_key)).must_equal expected_header_blob
    end

    it "should create header table" do
      service.instance_variable_set(:@storage_type, 'blob')
      _(service.getAuthenticationHeader(method, path, params, headers, storage_suffix, storage_account_name, storage_account_key)).must_equal expected_header_table
    end

    it "fails with unsupported storage type" do
      service.instance_variable_set(:@storage_type, 'doesnt_exist')

      assert_raises(Azure::StorageService::StorageTypeError) do
        service.getAuthenticationHeader(method, path, params, headers, storage_suffix, storage_account_name, storage_account_key)
      end
    end
  end
end