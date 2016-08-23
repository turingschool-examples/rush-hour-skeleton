require_relative '../test_helper'
require './app/models/payload_request'

class PayloadRequestTest < Minitest::Test
  def test_it_finds_an_active_record_object
    PayloadRequest.create({url: "a Url",
                          requested_at: '2016-08-23',
                          responded_in: 3,
                          referred_by: "another URL",
                          request_type: "get",
                          user_agent: "an agent!",
                          resolution_width: "2",
                          resolution_height: "3",
                          ip: "127.0.0.1"
                          })
    payload_request = PayloadRequest.first

    assert_instance_of PayloadRequest, payload_request
    assert_kind_of ActiveRecord::Base, payload_request
  end

  def test_it_validates_payloads_for_completeness
    payload_happy = PayloadRequest.new({url: "a Url",
                          requested_at: '2016-08-23',
                          responded_in: 3,
                          referred_by: "another URL",
                          request_type: "get",
                          user_agent: "an agent!",
                          resolution_width: "2",
                          resolution_height: "3",
                          ip: "127.0.0.1"
                          })
    assert payload_happy.save

    payload_sad = PayloadRequest.new({requested_at: '2016-08-23',
                          responded_in: 3,
                          referred_by: "another URL",
                          request_type: "get",
                          user_agent: "an agent!",
                          resolution_width: "2",
                          resolution_height: "3",
                          ip: "127.0.0.1"
                          })

    refute payload_sad.save
  end
end
