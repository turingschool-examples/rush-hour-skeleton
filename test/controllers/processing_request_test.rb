require './test/test_helper'
require 'json'

class ProcessingRequestTest < ControllerTest
  def test_payload_data_equal_json_data
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data

    assert_equal 1, TrafficSpy::Source.count
    assert_equal 1, TrafficSpy::Payload.count
    assert_equal 200, last_response.status
    assert_equal "Created Successfully", last_response.body
  end

  def test_users_receives_400_missing_payload_error
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', nil

    assert_equal 1, TrafficSpy::Source.count
    assert_equal 0, TrafficSpy::Payload.count
    assert_equal 400, last_response.status
    assert_equal "payload can't be blank", last_response.body
  end

  def test_two_different_payloads_have_different_hexs
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data

    assert_equal 1, TrafficSpy::Payload.count
    assert_equal 200, last_response.status
    assert_equal "Created Successfully", last_response.body

    post '/sources/jumpstartlab/data', payload_data_two

    assert_equal 2, TrafficSpy::Payload.count
    assert_equal 200, last_response.status
    assert_equal "Created Successfully", last_response.body
  end

  def test_user_receives_403_error_for_duplicate_payload
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data

    assert_equal 1, TrafficSpy::Payload.count
    assert_equal 200, last_response.status
    assert_equal "Created Successfully", last_response.body

    post '/sources/jumpstartlab/data', payload_data

    assert_equal 403, last_response.status
    assert_equal "Hex digest has already been taken", last_response.body
  end

  def test_user_receives_403_error_for_not_registered
    post '/sources/jumpstartlab/data', payload_data

    assert_equal 403, last_response.status
    assert_equal "Identifier does not exist", last_response.body
  end

  def test_payload_given_proper_foreign_key_for_source
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources', { identifier:  "id2",
                       rootUrl:     "http://id2.com" }
    post '/sources/jumpstartlab/data', payload_data
    post '/sources/id2/data', payload_data_two

    assert_equal 2, TrafficSpy::Source.count
    assert_equal 2, TrafficSpy::Payload.count

    assert_equal 1, TrafficSpy::Payload.first.source_id
    #assertion about source identifier
    assert_equal 2, TrafficSpy::Payload.last.source_id
  end

  def test_payload_given_proper_foreign_key_for_url
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources', { identifier:  "id2",
                       rootUrl:     "http://id2.com" }

    post '/sources/jumpstartlab/data', payload_data

    assert_equal 1, TrafficSpy::Payload.first.url_id
    assert_equal "http://jumpstartlab.com/blog", TrafficSpy::URL.first.url

    post '/sources/id2/data', payload_data_id_2_com

    assert_equal 2, TrafficSpy::Payload.last.url_id
    assert_equal "http://something.com", TrafficSpy::URL.last.url
  end

  def test_payload_given_proper_foreign_key_for_event_name
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources', { identifier:  "id2",
                       rootUrl:     "http://id2.com" }

    post '/sources/jumpstartlab/data', payload_data

    assert_equal 1, TrafficSpy::Payload.first.event_id
    assert_equal "socialLogin", TrafficSpy::Event.first.event_name

    post '/sources/id2/data', payload_data_id_2_com

    assert_equal 2, TrafficSpy::Payload.last.event_id
    assert_equal "die with your boots on", TrafficSpy::Event.last.event_name
  end

  def test_payload_given_proper_foreign_key_for_user_agent
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources', { identifier:  "id2",
                       rootUrl:     "http://id2.com" }

    post '/sources/jumpstartlab/data', payload_data

    assert_equal 1, TrafficSpy::Payload.first.agent_id
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", TrafficSpy::Agent.first.agent

    post '/sources/id2/data', payload_data_id_2_com

    assert_equal 2, TrafficSpy::Payload.last.agent_id
    assert_equal "Mozilla/5.0 (Linoox; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", TrafficSpy::Agent.last.agent
  end

  def test_payload_given_proper_foreign_key_for_ip_address
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources', { identifier:  "id2",
                       rootUrl:     "http://id2.com" }

    post '/sources/jumpstartlab/data', payload_data

    assert_equal 1, TrafficSpy::Payload.first.ip_id
    assert_equal "63.29.38.211", TrafficSpy::Ip.first.ip

    post '/sources/id2/data', payload_data_id_2_com

    assert_equal 2, TrafficSpy::Payload.last.ip_id
    assert_equal "666.666.666.666", TrafficSpy::Ip.last.ip
  end


  def payload_data
     {"payload" => {"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211" }.to_json }
  end

  def payload_data_two
     {"payload" => {"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":666,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName":"die with your boots on",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211" }.to_json }
  end

  def payload_data_id_2_com
    {"payload" => {"url":"http://something.com",
     "requestedAt":"2013-02-16 21:38:28 -0700",
     "respondedIn":666,
     "referredBy":"http://jumpstartlab.com",
     "requestType":"GET",
     "parameters":[],
     "eventName":"die with your boots on",
     "userAgent":"Mozilla/5.0 (Linoox; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
     "resolutionWidth":"1920",
     "resolutionHeight":"1280",
     "ip":"666.666.666.666" }.to_json }
 end
end
