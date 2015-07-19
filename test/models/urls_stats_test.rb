require_relative '../test_helper'

class UrlsStatsTest  < Minitest::Test

  def setup
    @url = Url.new({ "url" => "myspace.com/test", "request_type" => "GET", "responded_in" => 22,
      "referred_by" => "google.com" })
    @url.save
    @url2 = Url.new({ "url" => "myspace.com/test", "request_type" => "POST", "responded_in" => 32,
      "referred_by" => "facebook.com" })
    @url2.save
  end

  def test_it_can_find_longest_response_time
    assert_equal 32, UrlsStatisticsCalculator.new(@url).find_longest_response_time
  end

  def test_it_can_find_shortest_response_time
    assert_equal 22, UrlsStatisticsCalculator.new(@url).find_shortest_response_time
  end

  def test_it_can_find_average_response_time
    assert_equal 27, UrlsStatisticsCalculator.new(@url).find_average_response_time
  end

  def test_it_can_find_http_verbs
    assert_equal "GET, POST", UrlsStatisticsCalculator.new(@url).get_http_verbs
  end

  def test_it_can_find_referred_by
    assert_equal "google.com, facebook.com", UrlsStatisticsCalculator.new(@url).get_referred_by
  end


end
