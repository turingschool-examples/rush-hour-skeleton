require './test/test_helper'

class ProcessPayloadTest < ModelTest
  def turing_payload_parameters
    '{ "url":"http://turing.io/blog",
       "requestedAt":"2013-02-16 21:38:28 -0700",
       "respondedIn":37,
       "referredBy":"http://turing.io",
       "requestType":"GET",
       "parameters":[],
       "eventName": "socialLogin",
       "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
       "resolutionWidth":"1920",
       "resolutionHeight":"1280",
       "ip":"63.29.38.211"
      }'
  end

  def test_initializes_processor_from_payload_params_and_identifier
    id = 'turing'
    TrafficSpy::Application.create({ identifier: id, root_url: 'http://turing.io' })

    params = turing_payload_parameters

    processor = TrafficSpy::ProcessPayload.new(params, id)

    assert_equal TrafficSpy::Application, processor.app.class
    assert_equal id, processor.app.identifier
    assert_equal params, processor.payload
  end

  def test_process_returns_400_response_when_payload_is_nil
    id = 'turing'
    TrafficSpy::Application.create({ identifier: id, root_url: 'http://turing.io' })

    processor = TrafficSpy::ProcessPayload.new(nil, id)

    assert_nil processor.payload

    expected = [400, "Payload can't be blank"]

    assert_equal expected, processor.process
  end

  def test_process_returns_403_response_when_app_not_registered
    id = 'turing'
    params = turing_payload_parameters

    processor = TrafficSpy::ProcessPayload.new(params, id)

    expected = [403, "Identifier not registered"]

    assert_equal expected, processor.process
  end

  def test_process_returns_403_response_when_app_not_registered_and_payload_is_nil
    id = 'turing'

    processor = TrafficSpy::ProcessPayload.new(nil, id)

    expected = [403, "Identifier not registered"]

    assert_equal expected, processor.process
  end

  def test_process_returns_403_response_when_request_already_received
    id = 'turing'
    TrafficSpy::Application.create({ identifier: id, root_url: 'http://turing.io' })

    params = turing_payload_parameters

    processor = TrafficSpy::ProcessPayload.new(params, id)
    processor.process

    expected = [403, "Already received request"]

    assert_equal expected, processor.process
  end

  def test_process_returns_200_response_when_request_is_valid_and_can_be_saved
    id = 'turing'
    TrafficSpy::Application.create({ identifier: id, root_url: 'http://turing.io' })

    params = turing_payload_parameters

    processor = TrafficSpy::ProcessPayload.new(params, id)

    expected = [200, ""]

    assert_equal expected, processor.process
  end
end
