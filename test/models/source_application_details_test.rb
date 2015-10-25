require './test/test_helper'
class SourceApplicationDetailsTest < Minitest::Test

  def test_payloads_are_being_added_to_database
    sources = TrafficSpy::Source
    payloads = TrafficSpy::Payload
    create_sources(5)

    prepared_payload = TrafficSpy::Validator.prepare_payload('payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}')

    psyduck = TrafficSpy::Validator.validate_payload("jumpstartlab", prepared_payload, sources)



    #assert_equal 5, sources.all.count
    refute_equal true, payloads.all.includes?(psyduck)
  end
end
