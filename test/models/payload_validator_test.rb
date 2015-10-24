require './test/test_helper'
class PayloadValidatorTest < Minitest::Test

  def test_payload_validator_excludes_payloads_with_missing_attributes
    payloads = TrafficSpy::Payload
    result = payloads.create({
                    :requested_at=>"2013-02-16 21:38:28 -0700",
                    :responded_in=>37,
                    :referred_by=>"http://jumpstartlab.com",
                    :request_type=>"GET",
                    :parameters=>[],
                    :event_name=>"socialLogin",
                    :user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    :resolution_width=>"1920",
                    :resolution_height=>"1280",
                    :ip=>"63.29.38.211"})

    assert_equal 0, payloads.all.count
  end

  def test_payload_validator_excludes_duplicate_payloads
    payloads  = TrafficSpy::Payload
    result_one = payloads.create({:url=>"http://jumpstartlab.com/blog",
                    :requested_at=>"2013-02-16 21:38:28 -0700",
                    :responded_in=>37,
                    :referred_by=>"http://jumpstartlab.com",
                    :request_type=>"GET",
                    :parameters=>[],
                    :event_name=>"socialLogin",
                    :user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    :resolution_width=>"1920",
                    :resolution_height=>"1280",
                    :ip=>"63.29.38.211"})

    assert result_one

    result_two = payloads.create({:url=>"http://jumpstartlab.com/blog",
                    :requested_at=>"2013-02-16 21:38:28 -0700",
                    :responded_in=>37,
                    :referred_by=>"http://jumpstartlab.com",
                    :request_type=>"GET",
                    :parameters=>[],
                    :event_name=>"socialLogin",
                    :user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    :resolution_width=>"1920",
                    :resolution_height=>"1280",
                    :ip=>"63.29.38.211"})
    assert_equal 1, payloads.count
    refute payloads.all.include?(result_two)
  end

  def test_payload_validator_excludes_payloads_for_unregistered_source
    sources = TrafficSpy::Source
    registered = sources.create({identifier: "jumpstartlab",
                                 root_url: "http://jumpstartlab.com"})
    payloads  = TrafficSpy::Payload
    payload_of_unregistered_source = payloads.create({:url=>"http://unregistered_source.com/blog",
                    :requested_at=>"2013-02-16 21:38:28 -0700",
                    :responded_in=>37,
                    :referred_by=>"http://unregistered_source.com",
                    :request_type=>"GET",
                    :parameters=>[],
                    :event_name=>"socialLogin",
                    :user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                    :resolution_width=>"1920",
                    :resolution_height=>"1280",
                    :ip=>"63.29.38.211"})

    assert_equal [403, "App Not Registered!"],TrafficSpy::Validator.validate_payload(registered, payload_of_unregistered_source, sources)
    #does this need to be a test?
    #it is a test that interacts with both databases so is it not a model test?
  end

  def test_payload_validator_excludes_missing_payloads
    payloads = TrafficSpy::Payload
    result = payloads.create({})

    assert_equal 0, payloads.all.count
  end

end
