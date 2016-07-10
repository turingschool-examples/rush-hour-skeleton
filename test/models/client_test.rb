require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_creates_client_with_correct_attributes
    create_payload(1)
    client = Client.find(1)

    assert_equal "jumpstartlab0", client.identifier
    assert_equal "http://jumpstartlab.com", client.root_url
  end

  def test_all_through_client_relationships
    create_payload(1)
    client = Client.find(1)
    assert_equal 1, client.urls.length
    assert_equal 1, client.request_types.length
    assert_equal 1, client.ips.length
    assert_equal 1, client.request_types.length
    assert_equal 1, client.resolutions.length
    assert_equal 1, client.software_agents.length
    assert_equal 1, client.referrers.length
    assert_equal 1 ,client.parameters.length
  end

  def test_max_response_time
    create_payload2(2)
    create_payload3(3)
    create_payload4(4)

    assert_equal 20, Client.last.max_response_time
  end

  def test_min_response_time
    create_payload2(2)
    create_payload3(3)
    create_payload4(4)

    assert_equal 5, Client.first.min_response_time
  end

  def test_average_response_time
    create_payload2(2)
    create_payload3(3)
    create_payload4(4)

    assert_equal 5, Client.first.average_response_time
  end

  def test_list_of_all_http_verbs_used
    create_payload2(2)
    create_payload3(3)
    create_payload4(4)

    assert_equal ["GET"], Client.first.list_of_all_http_verbs_used
  end

  def test_most_frequent_request_type
    create_payload2(2)
    create_payload3(3)
    create_payload4(4)

    expected = "GET"
    assert_equal expected, Client.first.most_frequent_request_type
  end

  def test_list_urls_from_most_to_least
    create_payload2(2)
    create_payload3(3)
    create_payload4(4)

    expected = "http://turing.io/blog"
    assert_equal expected, Client.first.list_urls_from_most_to_least
  end

  def test_web_browser_breakdown
    create_payload2(2)
    create_payload3(3)
    create_payload4(4)

    expected = ["Firefox"]
    assert_equal expected, Client.first.web_browser_breakdown
  end

  def test_web_os_breakdown
    create_payload2(2)
    create_payload3(3)
    create_payload4(4)

    expected = ["OSX 10.9.0"]
    assert_equal expected, Client.first.web_os_breakdown
  end

  def test_all_screen_resolutions
    create_payload2(2)
    create_payload3(3)
    create_payload4(4)

    expected = ["1366 X 768"]
    assert_equal expected, Client.first.all_screen_resolutions
  end

  def test_client_can_return_list_of_relative_paths
   create_payload(1)
   expected = "http://jumpstartlab.com/blog0"

   assert_equal expected, Client.first.find_url_by_relative_path("blog0").address
 end

 def test_relative_path_exists
   create_payload(1)
   assert Client.first.relative_path_exists?("blog0")
   refute Client.first.relative_path_exists?("other")
 end

end
