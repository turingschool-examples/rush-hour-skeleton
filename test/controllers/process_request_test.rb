require './test/test_helper'

class ProcessRequestTest < ControllerTest
  def test_does_not_process_request_without_payload
    TrafficSpy::Application.create({ identifier: "turing", root_url: "http://turing.io"})

    post '/sources/turing/data'

    assert_equal 400, last_response.status
    assert_equal "Payload can't be blank", last_response.body
    assert_equal 0, TrafficSpy::Payload.count
  end

  def test_does_not_process_request_for_unregistered_application
    payload = { payload: '{
                          "url":"http://jumpstartlab.com/blog",
                          "requestedAt":"2013-02-16 21:38:28 -0700",
                          "respondedIn":37,
                          "referredBy":"http://jumpstartlab.com",
                          "requestType":"GET",
                          "parameters":[],
                          "eventName": "socialLogin",
                          "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          "resolutionWidth":"1920",
                          "resolutionHeight":"1280",
                          "ip":"63.29.38.211"
                          }'
    }

    post '/sources/turing/data', payload

    assert_equal 403, last_response.status
    assert_equal "Identifier not registered", last_response.body
    assert_equal 0, TrafficSpy::Payload.count
  end

  def test_responds_with_200_for_valid_and_unique_payload
    TrafficSpy::Application.create({ identifier: "turing", root_url: "http://turing.io"})

    payload = { payload: '{
                          "url":"http://turing.io/blog",
                          "requestedAt":"2013-02-16 21:38:28 -0700",
                          "respondedIn":37,
                          "referredBy":"http://turing.io",
                          "requestType":"GET",
                          "parameters":[],
                          "eventName": "socialLogin",
                          "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          "resolutionWidth":"1920",
                          "resolutionHeight":"1280",
                          "ip":"63.29.38.211"
                          }'
    }

    post '/sources/turing/data', payload

    assert_equal 200, last_response.status
    assert_equal 1, TrafficSpy::Payload.count
  end

  def test_responds_with_403_for_a_non_unique_payload
    TrafficSpy::Application.create({ identifier: "turing", root_url: "http://turing.io"})

    payload = { payload: '{
                          "url":"http://turing.io/blog",
                          "requestedAt":"2013-02-16 21:38:28 -0700",
                          "respondedIn":37,
                          "referredBy":"http://turing.io",
                          "requestType":"GET",
                          "parameters":[],
                          "eventName": "socialLogin",
                          "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          "resolutionWidth":"1920",
                          "resolutionHeight":"1280",
                          "ip":"63.29.38.211"
                          }'
    }

    parser = TrafficSpy::ProcessRequestParser.new

    TrafficSpy::Application.find(1).payloads.create(parser.parse_request(payload[:payload]))

    post '/sources/turing/data', payload

    assert_equal 403, last_response.status
    assert_equal "Already received request", last_response.body
  end

  def test_allows_two_unique_payloads_with_different_urls
    TrafficSpy::Application.create({ identifier: "turing", root_url: "http://turing.io"})

    payload1 = { payload: '{
                          "url":"http://turing.io/blog",
                          "requestedAt":"2013-02-16 21:38:28 -0700",
                          "respondedIn":37,
                          "referredBy":"http://turing.io",
                          "requestType":"GET",
                          "parameters":[],
                          "eventName": "socialLogin",
                          "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          "resolutionWidth":"1920",
                          "resolutionHeight":"1280",
                          "ip":"63.29.38.211"
                          }'
    }

    payload2 = { payload: '{
                          "url":"http://turing.io/team",
                          "requestedAt":"2013-02-16 21:38:28 -0700",
                          "respondedIn":37,
                          "referredBy":"http://turing.io",
                          "requestType":"GET",
                          "parameters":[],
                          "eventName": "socialLogin",
                          "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          "resolutionWidth":"1920",
                          "resolutionHeight":"1280",
                          "ip":"63.29.38.211"
                          }'
    }

    parser = TrafficSpy::ProcessRequestParser.new

    TrafficSpy::Application.find(1).payloads.create(parser.parse_request(payload1[:payload]))

    post '/sources/turing/data', payload2

    assert_equal 200, last_response.status
  end
end
