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
  
  def test_it_can_return_all_response_times_per_url
    PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 5,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
                            
    PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 4,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    assert_equal [5, 4, 3], @url.response_times_from_highest_to_lowest
  end

  def test_it_knows_http_verbs_for_this_url
    assert_equal [], @url.http_verbs
  end
  
  def test_it_returns_most_requested_urls
    @url2 = Url.create(web_address: "http://www.google.com")
    @payload2 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url2.id
                            })
    @payload3 = PayloadRequest.create({ requested_at: '2016-08-25',
                            responded_in: 1,
                            resolution_id: 1,
                            system_information_id: 1,
                            referral_id: 1,
                            ip_id: 1,
                            request_type_id: 1,
                            url_id: @url2.id
                            })
    assert_equal ["http://www.google.com", "http://www.example.com"], Url.most_requested_urls
  end

  def test_it_can_return_top_3_referrers_to_a_site
    referral1 = Referral.create({referred_by: "Google"})
    referral2 = Referral.create({referred_by: "Yahoo"})
    referral3 = Referral.create({referred_by: "Turing"})
    referral4 = Referral.create({referred_by: "Etsy"})
    payload1 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: referral1.id,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    payload2 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: referral1.id,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    payload3 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: referral2.id,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    payload4 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: referral2.id,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    payload5 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: referral3.id,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    payload6 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: referral3.id,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    payload7 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: referral4.id,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    payload8 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: referral3.id,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })
    payload9 = PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 3,
                            resolution_id: 1,
                            system_information_id: 2,
                            referral_id: referral1.id,
                            ip_id: 4,
                            request_type_id: 5,
                            url_id: @url.id
                            })

    assert_equal ["Turing", "Google", "Yahoo"], @url.top_three_referrers
  end
end
