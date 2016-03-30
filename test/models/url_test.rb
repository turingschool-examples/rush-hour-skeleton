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

  def test_it_returns_from_most_to_least_requested_urls
    setup_data

    assert_equal ["http://jumpstartlab.com", "http://turing.io"], Url.most_to_least_requested
  end

  def test_it_lists_all_verbs_given_url
    setup_data

    assert_equal ["POST"], Url.find(3).list_all_verbs_given_url
    assert_equal ["GET"], Url.find(1).list_all_verbs_given_url
  end

#  def test_it_lists_top_three_referrers
#    url_id = Url.create(address: "turing.io")
#
#    referrer_data
#
#    assert_equal [expect newegg], Url.find(1).list_top_three_referrers
#  end

end
