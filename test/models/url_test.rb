require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

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

end
