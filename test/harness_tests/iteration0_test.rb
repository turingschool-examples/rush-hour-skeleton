# require './test/test_helper'
#
# class Iteration0Test < Minitest::Test
#
#   def test_payload_request_exists
#     assert PayloadRequest.new
#   end
#
#   def test_payload_request_has_correct_attributes
#     create_payload_request
#
#     payload = PayloadRequest.first
#
#     assert_respond_to payload, :url
#     assert_respond_to payload, :requested_at
#     assert_respond_to payload, :responded_in
#     assert_respond_to payload, :referred_by
#     assert_respond_to payload, :request_type
#     assert_respond_to payload, :event_name
#     assert_respond_to payload, :user_agent
#     assert_respond_to payload, :resolution_width
#     assert_respond_to payload, :resolution_height
#     assert_respond_to payload, :ip
#   end
# end
