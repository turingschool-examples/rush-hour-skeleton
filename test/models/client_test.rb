require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_client
    setup_client

    assert_equal 1, Client.all.first.id
    assert_equal "jumpstartlab", Client.all.first.identifier
    assert_equal "http://jumpstartlab.com", Client.all.first.root_url
  end

  def test_it_fails_with_a_client_with_no_identifier
    setup_client
    Client.create(identifier: nil, root_url: "http://jumpstartlab.com")

    assert_equal 1, Client.all.count
  end

  def test_it_fails_with_a_client_with_no_root_url
    setup_client
    Client.create(identifier: "jumpstartlab", root_url: nil)

    assert_equal 1, Client.all.count
  end

  def test_max_response_time
    referrer_data
    Client.find(1)

    assert_equal 40, Client.find(1).max_response_time
  end

  def test_max_response_time_given_a_different_url
    referrer_data
    client = Client.find_by(identifier: "turing")

    assert_equal 10, client.max_response_time
  end

  def test_min_response_time
    referrer_data
    Client.find(1)

    assert_equal 10, Client.find(1).min_response_time
  end

  def test_all_response_time_from_most_to_least
    referrer_data
    client = Client.find(1)

    assert_equal [40, 30, 20, 10], client.all_response_time_from_most_to_least
  end

  def test_average_response_time
    referrer_data
    client = Client.find(1)

    assert_equal 25.0, client.average_response_time
  end

  def test_average_response_time_different_url
    referrer_data
    client = Client.find(2)

    assert_equal 10.0, client.average_response_time
  end

  def test_it_lists_all_verbs
    referrer_data
    client = Client.find(1)

    assert_equal ["GET", "POST"], client.list_all_verbs
  end

  def test_it_lists_top_three_referrers
   referrer_data

   client = Client.find(1)
   assert_equal ["http://amazon.com", "http://newegg.com", "http://jumpstartlab.com"], client.list_top_three_referrers
  end

  def test_it_lists_top_three_u_agents
   referrer_data

   client = Client.find(1)
   assert_equal [["Mozilla", "Windows"], ["Chrome", "Macintosh"], ["Opera", "Webkit"]], client.list_top_three_u_agents
  end

  def test_it_lists_most_requested_verb
   referrer_data

   client = Client.find(1)
   assert_equal "GET", client.most_requested_verb
  end

  def test_it_lists_urls_most_frequent_to_least
   referrer_data

   client = Client.find(1)
   assert_equal ["http://turing.io"], client.most_to_least_frequent_urls
  end

  def test_it_lists_browsers
   referrer_data

   client = Client.find(1)
   assert_equal ["Mozilla", "Opera", "Chrome"], client.browsers
  end

  def test_it_lists_platforms
   referrer_data

   client = Client.find(1)
   assert_equal ["Windows", "Webkit", "Macintosh"], client.platforms
  end

  def test_it_lists_screen_resolutions
   referrer_data

   client = Client.find(1)
   assert_equal ["2560x1440", "1920x1280"], client.screen_resolutions
  end

  def test_can_find_clients_payload_requests_by_relative_path
    referrer_data

    client = Client.find(1)
    assert_equal nil, client.find_payload_requests_by_relative_path(path)
  end
end
