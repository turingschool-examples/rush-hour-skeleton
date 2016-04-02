require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_url
    url = Url.create(address: "www.turing.io")

    assert_equal "www.turing.io", url.address
  end

  def test_it_checks_for_empty_address
    url = Url.create(address: nil)

    assert_nil url.address
  end

  def test_it_responds_with_an_error_message
    url = Url.create(address: nil)

    assert_equal "can't be blank", url.errors.messages[:address][0]
  end

  def test_max_response_time_given_url
    setup_data
    Url.find(1)

    assert_equal 40, Url.find(1).max_response_time_given_url
  end

  def test_max_response_time_given_a_different_url
    setup_data
    url = Url.find_by(address: "http://turing.io")

    assert_equal 30, url.max_response_time_given_url
  end

  def test_min_response_time_given_url
    setup_data
    Url.find(1)

    assert_equal 20, Url.find(1).min_response_time_given_url
  end

  def test_all_response_time_from_most_to_least_given_url
    setup_data
    url = Url.find(1)

    assert_equal [40, 20], url.all_response_time_from_most_to_least_given_url
  end

  def test_average_response_time_given_url
    setup_data
    url = Url.find(1)

    assert_equal 30.0, url.average_response_time_given_url
  end

  def test_average_response_time_different_url
    setup_data
    url = Url.find(2)

    assert_equal 30.0, url.average_response_time_given_url
  end

  def test_it_lists_all_verbs_given_url
    setup_data
    url = Url.find(1)

    assert_equal ["GET", "POST"], url.list_all_verbs_given_url
  end

 def test_it_lists_top_three_referrers_given_url
   referrer_data

   url = Url.find(1)
   assert_equal ["http://jumpstartlab.com", "http://amazon.com", "http://newegg.com"], url.list_top_three_referrers_given_url
 end

 def test_it_lists_top_three_u_agents_given_url
   referrer_data

   url = Url.find(1)
   assert_equal [["Mozilla", "Windows"], ["Chrome", "Macintosh"], ["Opera", "Webkit"]], url.list_top_three_u_agents_given_url
 end
end
