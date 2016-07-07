require_relative '../test_helper.rb'

class DataProcessorTest < Minitest::Test
  include DataProcessor, TestHelpers

  def raw_data
    '{
      "url": "http://jumpstartlab.com/blog",
      "requestedAt": "2013-02-16 21:38:28 -0700",
      "respondedIn": 37,
      "referredBy": "http://jumpstartlab.com",
      "requestType": "GET",
      "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth": "1920",
      "resolutionHeight": "1280",
      "ip": "63.29.38.211"
     }'
  end

  def test_it_can_appropriately_label_data_for_columns
    data = parse_it(raw_data)
    formatted = assign_data(data)
    assert_equal 37, formatted[:responded_in]
  end

  def test_it_can_assign_url_data
    data = parse_it(raw_data)
    formatted = assign_data(data)
    assign_data_to_url(formatted)
    assert_equal "http://jumpstartlab.com", Url.first.root_url
    assert_equal "/blog", Url.first.path
  end

  def test_it_can_assign_referred_by_data
    data = parse_it(raw_data)
    formatted = assign_data(data)
    assign_data_to_referred_by(formatted)
    assert_equal "http://jumpstartlab.com", ReferredBy.first.root_url
    assert_equal "/blog", ReferredBy.first.path
  end

  def test_it_can_assign_user_agent_data
    data = parse_it(raw_data)
    formatted = assign_data(data)
    assign_data_to_user_agent(formatted)
    assert_equal "Chrome", UAgent.first.browser
    assert_equal "Macintosh", UAgent.first.operating_system
  end

  def test_it_can_assign_resolution_data
    data = parse_it(raw_data)
    formatted = assign_data(data)
    assign_data_to_resolution(formatted)
    assert_equal 1920, Resolution.first.width
    assert_equal 1280, Resolution.first.height
  end

  def test_it_can_assign_ip_data
    data = parse_it(raw_data)
    formatted = assign_data(data)
    assign_data_to_ip(formatted)
    assert_equal "63.29.38.211", Ip.first.address
  end

  def test_it_can_store_all_data_from_a_payload
    loaded = process_payload(raw_data)

    assert loaded.requested_at
    assert_equal 37, loaded.responded_in
    assert_equal 1, loaded.url_id
    assert_equal 1, loaded.request_type_id
    assert_equal 1, loaded.resolution_id
    assert_equal 1, loaded.ip_id
    assert_equal 1, loaded.u_agent_id
    assert_equal 1, loaded.referred_by_id
  end
end
