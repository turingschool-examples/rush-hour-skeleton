require_relative '../test_helper'

class PayloadLoaderTest < Minitest::Test
  include TestHelper
  # def test_it_can_load_a_payload
  #   user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
  #   client = Client.create({identifier: "id", rootUrl: "wwww.id.com/"})
  #   raw_payload = {
  #     "url" => "www.url.com/",
  #     "requestedAt" => Time.now.to_s,
  #     "respondedIn" => 1,
  #     "referredBy" => "www.referral.com/",
  #     "requestType" => "GET",
  #     "eventName" => "name",
  #     "userAgent" => user_agent,
  #     "ip" => "fake ip",
  #     "resolutionWidth" => "1920",
  #     "resolutionHeight" => "1080"}
  #   }

  def test_it_can_get_client_id
    payload_loader = PayloadLoader.new
    fake_client = Client.create(identifier: "fake_client",
                                rootUrl:    "www.fake_client.com")

    id = payload_loader.get_client_id("fake_client")

    assert_equal fake_client.id, id
  end

  def test_it_can_load_ip_and_return_ip_id
    payload_loader = PayloadLoader.new

    expected_id = payload_loader.load_ip("1.111.1.1")

    actual_id = Ip.all.first.id

    assert_equal actual_id, expected_id
  end

  def test_it_can_load_resolution_and_return_resolution_id
    payload_loader = PayloadLoader.new

    expected_id = payload_loader.load_resolution("fake width", "fake height")

    actual_id = Resolution.all.first.id

    assert_equal actual_id, expected_id
  end

  def test_it_can_load_user_agent_and_return_user_agent_id
    payload_loader = PayloadLoader.new

    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"

    expected_id = payload_loader.load_user_agent(user_agent)

    actual_id = UserAgent.all.first.id

    assert_equal actual_id, expected_id
  end

  def test_it_can_load_user_event_name_and_return_event_id
    payload_loader = PayloadLoader.new

    expected_id = payload_loader.load_event_name("fake event")

    actual_id = Event.all.first.id

    assert_equal actual_id, expected_id
  end

  def test_it_can_load_request_type_and_return_request_id
    payload_loader = PayloadLoader.new

    expected_id = payload_loader.load_request_type("fake request type")

    actual_id = RequestType.all.first.id

    assert_equal actual_id, expected_id
  end

  def test_it_can_load_referral_and_return_referral_id
    payload_loader = PayloadLoader.new

    expected_id = payload_loader.load_referral("http://www.fake.com/fake")

    actual_id = Referral.all.first.id

    assert_equal actual_id, expected_id
  end

  def test_it_can_load_url_and_return_url_id
    payload_loader = PayloadLoader.new

    expected_id = payload_loader.load_url("http://wwww.fake.com/notfake")

    actual_id = Url.all.first.id

    assert_equal actual_id, expected_id
  end

  def test_url_parser_can_parse_a_url_with_path
    payload_loader = PayloadLoader.new

    path, root = payload_loader.url_parser("http://www.fake.com/reallyfake")

    assert_equal "http://www.fake.com", root
    assert_equal "/reallyfake", path
  end

  def test_url_parser_can_parse_a_url_with_root_path
    payload_parser = PayloadLoader.new

    path, root = payload_parser.url_parser("http://www.fake.com/")

    assert_equal "http://www.fake.com", root
    assert_equal "/", path
  end
end
