require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_creates_client_with_correct_attributes
    create_payloads(1)
    client = Client.find(1)

    assert_equal "jumpstartlab0", client.identifier
    assert_equal "http://jumpstartlab.com0", client.root_url
  end

  def test_all_through_client_relationships
    create_payloads(1)
    client = Client.find(1)

    assert_equal 1, client.urls.count
    assert_equal 1, client.referrers.count
    assert_equal 1, client.request_types.count
    assert_equal 1, client.requested_ats.count
    assert_equal 1, client.user_agents.count
    assert_equal 1, client.responded_ins.count
    assert_equal 1, client.parameters.count
    assert_equal 1, client.ips.count
    assert_equal 1, client.resolutions.count
    assert_equal 1, client.event_names.count
  end

    def test_it_finds_most_frequent_request_type
    create_payloads(1)

    PayloadRequest.find_or_create_by({
        :url => Url.create(name: "http://test.com"),
        :referrer => Referrer.create(name: "http://test.com"),
        :request_type => RequestType.find(1),
        :requested_at => RequestedAt.create(time: "test"),
        :event_name => EventName.create(name: "test"),
        :user_agent => PayloadUserAgent.create(browser: "test", platform: "test"),
        :responded_in => RespondedIn.create(time: 27),
        :parameter => Parameter.create(list: "[]"),
        :ip => Ip.create(value: "127.0.0.1"),
        :resolution => Resolution.create(width: "1920", height: "1280"),
        :client => Client.find(1) })

    client = Client.find(1)

    assert_equal 2, client.counts_request_type_max
    assert_equal ["GET 0"], client.most_frequent_request_type
  end

  def test_it_handles_most_frequent_request_type_when_there_is_a_tie
    create_payloads(1)

    PayloadRequest.find_or_create_by({
        :url => Url.create(name: "http://test.com"),
        :referrer => Referrer.create(name: "http://test.com"),
        :request_type => RequestType.create(verb: "POST 0"),
        :requested_at => RequestedAt.create(time: "test"),
        :event_name => EventName.create(name: "test"),
        :user_agent => PayloadUserAgent.create(browser: "test", platform: "test"),
        :responded_in => RespondedIn.create(time: 27),
        :parameter => Parameter.create(list: "[]"),
        :ip => Ip.create(value: "127.0.0.1"),
        :resolution => Resolution.create(width: "1920", height: "1280"),
        :client => Client.find(1) })

    client = Client.find(1)

    assert client.most_frequent_request_type.include?("POST 0")
    assert client.most_frequent_request_type.include?("GET 0")
  end

  def test_urls_get_returned_in_order_by_count_for_one
    create_payloads(1)
    client = Client.find(1)

    assert_equal ["http://jumpstartlab.com/blog0"], client.order_urls_by_count
  end

  def test_urls_get_returned_in_order_by_count_for_multiple
    create_payloads(1)

    PayloadRequest.find_or_create_by({
        :url => Url.create(name: "http://test.com"),
        :referrer => Referrer.create(name: "http://test.com"),
        :request_type => RequestType.find(1),
        :requested_at => RequestedAt.create(time: "test"),
        :event_name => EventName.create(name: "test"),
        :user_agent => PayloadUserAgent.create(browser: "test", platform: "test"),
        :responded_in => RespondedIn.create(time: 27),
        :parameter => Parameter.create(list: "[]"),
        :ip => Ip.create(value: "127.0.0.1"),
        :resolution => Resolution.create(width: "1920", height: "1280"),
        :client => Client.find(1) })

    client = Client.find(1)

    assert client.order_urls_by_count.include?("http://test.com")
    assert client.order_urls_by_count.include?("http://jumpstartlab.com/blog0")
  end
end
