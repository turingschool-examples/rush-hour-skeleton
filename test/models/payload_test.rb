require_relative '../test_helper'

class PayloadTest < TrafficTest
  include PayloadPrep

  def setup
    setup_model_testing_environment
    @user = TrafficSpy::User.find(1)
    @user_url_blog = @user.payloads.where(url: "http://jumpstartlab.com/blog")
  end

  def test_url_popularity
    expected_result = {"http://jumpstartlab.com/blog"=>2, "http://jumpstartlab.com/weather"=>1}
    assert_equal expected_result, @user.payloads.url_popularity
  end

  def test_browser_popularity
    expected_result = {"Chrome"=>2, "Safari"=>1}
    assert_equal expected_result, @user.payloads.browser_popularity
  end

  def test_os_popularity
    expected_result = {"Macintosh"=>2, "Windows"=>1}
    assert_equal expected_result, @user.payloads.os_popularity
  end

  def test_resolution_popularity
    expected_result = {1=>2, 2=>1}
    assert_equal expected_result, @user.payloads.resolution_popularity
  end

  def test_avg_response_time
    actual_result = @user.payloads.avg_response_time.map { |k, v| v}
    assert_equal [38, 39], actual_result
  end

  def test_max_response_time
    actual_result = @user_url_blog.max_response_time
    assert_equal  39, actual_result
  end

end
