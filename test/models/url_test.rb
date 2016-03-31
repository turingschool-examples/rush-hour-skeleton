require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers
  def setup_url
    url = Url.create(address: "http://jumpstartlab.com")
    Url.where(id: url.id)
  end

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
    setup_url
    setup_data

    assert_equal 40, Url.max_response_time_given_url
  end

  def test_max_response_time_given_a_different_url
    url = Url.create(address: "http://turing.io")
    Url.where(address: url.address)

    setup_data
    require "pry"; binding.pry

    assert_equal 30, Url.max_response_time_given_url
  end

  def test_min_response_time_given_url
    setup_url
    setup_data

    assert_equal 20, Url.min_response_time_given_url
  end

  def test_it_lists_all_verbs_given_url
    url= Url.create(address: "http://jumpstartlab.com")

    setup_data
    assert_equal ["GET", "POST"], Url.where(id: url.id).map(&:list_all_verbs_given_url).flatten
    # assert_equal ["GET"], Url.where(address: "http://jumpstartlab.com").list_all_verbs_given_url
  end

 def test_it_lists_top_three_referrers
   skip
   Url.create(address: "http://jumpstartlab.com")

   referrer_data
  # setup_data

   assert_equal ["http://newegg.com"], Url.find(url_id.id).list_top_three_referrers
 end

end
