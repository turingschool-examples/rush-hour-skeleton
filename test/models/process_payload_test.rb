require './test/test_helper'

class ProcessPayloadTest < ModelTest
  def test_initializes_processor_from_payload_params_and_identifier
    id = 'turing'
    TrafficSpy::Application.create({ identifier: id, root_url: 'http://turing.io' })

    params = 'payload ={ "url":"http://turing.io/blog",
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
    processor = TrafficSpy::ProcessPayload.new(params, id)

    assert_equal TrafficSpy::Application, processor.app.class
    assert_equal id, processor.app.identifier
    assert_equal params, processor.payload
  end
end
