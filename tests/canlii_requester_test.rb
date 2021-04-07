# frozen_string_literal: true

# Copyright (c) 2021 Samuel Y. Ayele
require 'test/unit'
require 'webmock'
require 'json'
require 'addressable'
require 'rest-client'
require 'byebug'
require 'nokogiri'
require 'down'
require 'fileutils'

require_relative '../libs/canlii_requester'

include WebMock::API
WebMock.enable!

# tests Canlii Requester Class in lib/
class CanliiRequesterTest < Test::Unit::TestCase
  BASE_URL = 'https://api.canlii.org/v1/'
  LEGISLATION_URI = 'legislationBrowse/en/'
  API_KEY = '2hhda3h2gkj34g3kj4hg3kj4g4g4ghjjjkk2jhg'

  url = "#{BASE_URL}#{LEGISLATION_URI}?api_key=#{API_KEY}"
  jurisdictions_file = File.read('webmocks/all_jurisdictions.json')
  # ------------------------------------------------------stub requests
  stub_request(:get, url)
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host' => 'api.canlii.org',
        'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.0p0'
      }
    )
    .to_return(status: 200, body: jurisdictions_file, headers: {})

  def test_ask_for_api_key_exists
    assert_true CanliiRequester.method_defined? :ask_for_api_key
  end

  def test_compose_request_exists
    assert_true CanliiRequester.method_defined? :compose_request
  end

  def test_get_request_exists
    assert_true CanliiRequester.method_defined? :get_request
  end

  def test_process_request_exists
    assert_true CanliiRequester.method_defined? :process_request
  end

  def test_obfuscate_cases_exists
    assert_true CanliiRequester.method_defined? :obfuscate_cases
  end

  def test_populate_case_list_exists
    assert_true CanliiRequester.method_defined? :populate_case_list
  end

  def test_get_all_databseids_exists
    assert_true CanliiRequester.method_defined? :get_all_databseids
  end

  def test_get_all_jurisdictions_exists
    assert_true CanliiRequester.method_defined? :get_all_jurisdictions
  end

  def test_randomize_jurisdiction_exists
    assert_true CanliiRequester.method_defined? :randomize_jurisdiction
  end

  def test_extract_topics_exists
    assert_true CanliiRequester.method_defined? :extract_topics
  end

  def test_extract_details_exists
    assert_true CanliiRequester.method_defined? :extract_details
  end

  def test_save_json_exists
    assert_true CanliiRequester.method_defined? :save_json
  end

  def test_load_json_exists
    assert_true CanliiRequester.method_defined? :load_json
  end

  def test_keep_log_exists
    assert_true CanliiRequester.method_defined? :keep_log
  end

  def test_display_error_exists
    assert_true CanliiRequester.method_defined? :display_error
  end

  def test_display_message_exists
    assert_true CanliiRequester.method_defined? :display_message
  end

  def test_get_request
    url = "#{BASE_URL}#{LEGISLATION_URI}?api_key=#{API_KEY}"
    request_tester = CanliiRequester.new
    response = request_tester.get_request(url, {})
    assert_false response.nil?
    assert_equal 34, JSON.parse(response.body)['legislationDatabases'].count
  end
end
