require_relative '../test_helper'
require './app/models/url'

class UrlTest < ModelTest
  def setup
    @url = Url.create(web_address: "http://www.example.com")
    @payload = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    super
  end
  def test_it_validates_input
    url = Url.new({web_address: "http://www.something.com"})

    url_sad = Url.new({})
    assert url.save
    refute url_sad.save
  end

  def test_it_has_unique_urls
    url = Url.new(web_address: "http://www.example.com")

    refute url.save
  end

  def test_it_knows_response_times_per_url
    response_times = @url.response_times
    assert_equal [3], response_times
  end

  def test_it_knows_the_longest_response_per_url
    assert_equal 3, @url.max_response_time
  end

  def test_it_knows_the_fastest_response_per_url
    assert_equal 3, @url.min_response_time
  end

  def test_it_can_average_response_times_per_url
    assert_equal 3, @url.average_response_time
  end

  def test_it_knows_http_verbs_for_this_url
    assert_equal [], @url.http_verbs
  end

  def test_it_can_return_top_3_referrers_to_a_site
    expected = {}
    assert_equal expected, @url.top_three_referrers
  end
end
