require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_responds_to_payloads
    e = Url.create(address: "http://www.google.com")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = Url.create(address: "http://www.google.com")

    assert_equal "http://www.google.com", e.address
  end

  def test_wont_validate_incorrect_data
    e = Url.create
    assert_nil e.id

    d = Url.new address: nil
    assert_nil d.address
  end

  def test_list_frequency_of_URLS_from_most_to_least
    setup_1
    expected = {"http://jumpstartlab.com"=>2, "http://jumpstartlab.com/jumps"=>1}
    assert_equal expected, Url.list_frequency_urls
  end

  def test_returns_max_response_time_for_given_url
    setup_1
    url = Url.find(1)
    assert_equal 30, url.max_url_response_time
  end

  def test_returns_min_response_time_for_given_url
    setup_1
    url = Url.find(1)
    assert_equal 20, url.min_url_response_time
  end

  def test_returns_all_response_times_for_given_url_sorted_by_length
    skip
    setup_1
    url = Url.find(1)
    assert_equal [30, 20], url.list_url_response_times
  end

  def test_return_average_response_time_for_given_url
    setup_1
    url = Url.find(1)
    assert_equal 25.0, url.average_url_response_time
  end

  def test_HTTP_verbs_used_to_acquire_this_url_returns_array
    setup_1
    url = Url.find(1)
    assert_equal ["POST", "GET"], url.show_all_url_verbs
  end

  def test_three_most_popular_refers
    skip
    setup_1
    url = Url.find(1)
    assert_equal ["http://turing.io", "http://google.com"], url.three_most_popular_url_refers
  end

end
