require_relative '../test_helper'

class UrlTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_partial_information_is_entered
    url = Url.new({ })
    refute url.save
  end

  def test_it_returns_true_when_all_information_is_entered
    url = Url.new({ address: "www's!"})
    assert url.save
  end

  def test_it_generates_list_of_urls_by_frequency
    url1 = Url.create({address: "http://www.google.com"})
    url2 = Url.create({address: "http://www.google.com"})
    url3 = Url.create({address: "http://www.nyt.com"})
    url4 = Url.create({address: "http://www.nyt.com"})
    url5 = Url.create({address: "http://www.nyt.com"})
    assert_equal ["http://www.nyt.com", "http://www.google.com"], Url.list_urls_by_frequency
  end

  # def test_can_find_max_response_time_for_specific_url
  #   url = Url.create({address: "http://www.google.com"})
  #   payload = PayloadRequest.create({url_id: 1, requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20, referred_by_id: 3, request_type_id: 1, parameters: [""], event_id: 2, user_agent_info_id: 1, screen_size_id: 1, ip_id: 1})
  #
  #   assert_equal 20, Url.url_max_response_time("http://www.google.com")
  # end
end
