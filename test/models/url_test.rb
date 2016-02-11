require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_list_urls_by_great_request_count
    create_payloads(4)
    urls = ["http://jumpstartlab.com/about", "http://jumpstartlab.com/blog", "http://google.com/about"]
    assert_equal urls, Url.most_frequent_urls
  end

  def test_url_max_response_time
    create_payloads(4)
    target_url = Url.find_by(route: "http://jumpstartlab.com/about")
    assert_equal 67.0, target_url.max_response_time
  end

  def test_url_min_response_time
    create_payloads(4)
    target_url = Url.find_by(route: "http://jumpstartlab.com/about")
    assert_equal 37.0, target_url.min_response_time
  end

  def test_return_all_sort_by_response_time
    create_payloads(4)
    target_url = Url.find_by(route: "http://jumpstartlab.com/about")
    assert_equal [67, 37], target_url.ranked_response_times
  end

  def test_return_average_response_time
    create_payloads(4)
    target_url = Url.find_by(route: "http://jumpstartlab.com/about")
    assert_equal 52, target_url.average_response_time
  end

  def test_verbs_associated_with_this_url
    create_payloads(4)
    target_url1 = Url.find_by(route: "http://jumpstartlab.com/about")
    target_url2 = Url.find_by(route: "http://google.com/about")
    assert_equal ["GET", "POST"], target_url1.associated_verbs
    assert_equal ["POST"], target_url2.associated_verbs
  end

  def test_three_most_popular_referrers
    create_payloads(5)
    target_url = Url.find_by(route: "http://jumpstartlab.com/about")
    assert_equal ["http://google.com", "http://jumpstartlab.com"], target_url.most_popular_referrer(3)
  end

  def test_three_most_popular_user_agents
    create_payloads(5)
    target_url = Url.find_by(route: "http://jumpstartlab.com/about")
    assert_equal [["Mac OS X 10.8.2", "Chrome 24.0.1309"], ["Windows 7", "AOL 9.7.4343"]], target_url.most_popular_user_agents(3)
  end

end
