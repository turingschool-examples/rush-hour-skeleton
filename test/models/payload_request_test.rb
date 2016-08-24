require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  # '''
  # validates :request_type_id,   presence: true
  # validates :target_url_id,     presence: true
  # validates :referrer_url_id,   presence: true
  # validates :resolution_id,     presence: true
  # validates :user_agent_id,     presence: true
  # validates :ip_id,             presence: true
  # validates :responded_in,      presence: true
  # validates :requested_at,      presence: true
  # '''
  def setup
    # payload = {
    #   "url":"http://jumpstartlab.com/blog",
    #   "requestedAt":"2013-02-16 21:38:28 -0700",
    #   "respondedIn":37,
    #   "referredBy":"http://jumpstartlab.com",
    #   "requestType":"GET",
    #   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    #   "resolutionWidth":"1920",
    #   "resolutionHeight":"1280",
    #   "ip":"63.29.38.211"
    # }
    #
    @snake_cased_data = {
      request_type_id: 1,
      target_url_id: 1,
      referrer_url_id: 1,
      resolution_id: 1,
      user_agent_id: 1,
      ip_id: 1 ,
      responded_in: 37,
      requested_at: "2013-02-16 21:38:28 -0700"
    }
  end

  def data_without(unwanted_key)
    @snake_cased_data.reject { |key| key == unwanted_key }
  end

  def test_can_be_created_with_correct_attributes
    req = PayloadRequest.create(@snake_cased_data)
    assert_equal req.request_type_id, 1
    assert_equal req.target_url_id, 1
    assert_equal req.referrer_url_id, 1
    assert_equal req.resolution_id, 1
    assert_equal req.user_agent_id, 1
    assert_equal req.ip_id, 1
    assert_equal req.responded_in, 37
    assert_equal req.requested_at, "2013-02-16 21:38:28 -0700"

    assert_equal true, req.valid?
  end

  def test_is_invalid_with_missing_request_type_id
    req = PayloadRequest.create(data_without(:request_type_id))
    assert req.request_type_id.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_target_url_id
    req = PayloadRequest.create(data_without(:target_url_id))
    assert req.target_url_id.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_referrer_url_id
    req = PayloadRequest.create(data_without(:referrer_url_id))
    assert req.referrer_url_id.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_resolution_id
    req = PayloadRequest.create(data_without(:resolution_id))
    assert req.resolution_id.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_user_agent_id
    req = PayloadRequest.create(data_without(:user_agent_id))
    assert req.user_agent_id.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_ip_id
    req = PayloadRequest.create(data_without(:ip_id))
    assert req.ip_id.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_responded_in
    req = PayloadRequest.create(data_without(:responded_in))
    assert req.responded_in.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_requested_at
    req = PayloadRequest.create(data_without(:requested_at))
    assert req.requested_at.nil?
    refute req.valid?
  end
end
