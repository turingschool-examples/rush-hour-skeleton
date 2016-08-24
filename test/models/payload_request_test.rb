require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers
  def setup
    @snake_cased_data = {
      url: "http://jumpstartlab.com/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://jumpstartlab.com",
      request_type: "GET",
      user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      resolution_width: "1920",
      resolution_height: "1280",
      ip: "63.29.38.211" }
  end

  def data_without(unwanted_key)
    @snake_cased_data.reject { |key| key == unwanted_key }
  end

  def test_can_be_created_with_correct_attributes
    req = PayloadRequest.create(@snake_cased_data)
    assert_equal req.url, "http://jumpstartlab.com/blog"
    assert_equal req.requested_at, "2013-02-16 21:38:28 -0700"
    assert_equal req.responded_in, 37
    assert_equal req.referred_by, "http://jumpstartlab.com"
    assert_equal req.request_type, "GET"
    assert_equal req.user_agent, "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
    assert_equal req.resolution_width, "1920"
    assert_equal req.resolution_height, "1280"
    assert_equal req.ip, "63.29.38.211"
    assert_equal true, req.valid?
  end

  def test_is_invalid_with_missing_url
    req = PayloadRequest.create(data_without(:url))
    assert req.url.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_requested_at
    req = PayloadRequest.create(data_without(:requested_at))
    assert req.requested_at.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_responded_in
    req = PayloadRequest.create(data_without(:responded_in))
    assert req.responded_in.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_referred_by
    req = PayloadRequest.create(data_without(:referred_by))
    assert req.referred_by.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_request_type
    req = PayloadRequest.create(data_without(:request_type))
    assert req.request_type.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_user_agent
    req = PayloadRequest.create(data_without(:user_agent))
    assert req.user_agent.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_resolution_width
    req = PayloadRequest.create(data_without(:resolution_width))
    assert req.resolution_width.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_resolution_height
    req = PayloadRequest.create(data_without(:resolution_height))
    assert req.resolution_height.nil?
    refute req.valid?
  end

  def test_is_invalid_with_missing_ip
    req = PayloadRequest.create(data_without(:ip))
    assert req.ip.nil?
    refute req.valid?
  end





end
