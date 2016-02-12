require_relative '../test_helper'

class UrlRequestTest < Minitest::Test
  include TestHelpers

  def test_has_attributes
    ur = UrlRequest.new

    assert_respond_to ur, :url
    assert_respond_to ur, :parameters
  end

  def test_attributes_must_be_present_when_saving
    url_request = UrlRequest.new

    refute url_request.save
    refute_equal 1, UrlRequest.all.count
  end

  def test_finds_max_response_time_for_specific_url
    create_payload_requests_with_associations(responded_in: 37)
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 10)

    url_request = UrlRequest.all.first

    assert_equal 50, url_request.max_response_time
  end

  def test_finds_min_response_time_for_specific_url
    create_payload_requests_with_associations(responded_in: 37)
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 10)

    url_request = UrlRequest.all.first

    assert_equal 10, url_request.min_response_time
  end

  def test_ordered_response_times_for_specific_url
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 30)
    create_payload_requests_with_associations(responded_in: 10)
    create_payload_requests_with_associations(responded_in: 50, url: "http://google.com")

    url_request = UrlRequest.find_by(url: "http://jumpstartlab.com/blog")

    assert_equal [50, 30, 10], url_request.ordered_response_times
  end

  def test_avg_response_time_for_specific_url
    create_payload_requests_with_associations(responded_in: 50)
    create_payload_requests_with_associations(responded_in: 30)
    create_payload_requests_with_associations(responded_in: 10)

    url_request = UrlRequest.find_by(url: "http://jumpstartlab.com/blog")

    assert_equal 30, url_request.avg_response_time
  end


  def test_all_verbs_associated_with_specific_url
    create_payload_requests_with_associations
    create_payload_requests_with_associations
    create_payload_requests_with_associations(request_type: 'POST')

    url_request = UrlRequest.find_by(url: 'http://jumpstartlab.com/blog')

    assert_equal 2, url_request.associated_verbs.count
    assert url_request.associated_verbs.include?("POST")
    assert url_request.associated_verbs.include?("GET")
  end

  def test_top_three_referrers_for_specific_url
    create_payload_requests_with_associations(referred_by: "http://pragmaticstudio.com")
    create_payload_requests_with_associations(referred_by: "http://coursereport.com")
    create_payload_requests_with_associations(referred_by: "http://google.com")
    create_payload_requests_with_associations(referred_by: "http://google.com")
    create_payload_requests_with_associations(referred_by: "http://pragmaticstudio.com")
    create_payload_requests_with_associations(referred_by: "http://google.com")
    create_payload_requests_with_associations(referred_by: "http://turing.io")
    create_payload_requests_with_associations(referred_by: "http://pragmaticstudio.com")
    create_payload_requests_with_associations(referred_by: "http://turing.io")
    create_payload_requests_with_associations(referred_by: "http://pragmaticstudio.com")

    url_request = UrlRequest.find_by(url: "http://jumpstartlab.com/blog")
    referrers = url_request.top_three_referrers

    assert_equal ["http://pragmaticstudio.com", "http://google.com", "http://turing.io"], referrers
  end

  def test_three_most_popular_user_agents
    user_agent_1 = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
    user_agent_2 = "Mozilla/5.0 (Windows NT 10.0; <64-bit tags>) AppleWebKit/<WebKit Rev> (KHTML, like Gecko) Chrome/<Chrome Rev> Safari/<WebKit Rev> Edge/<EdgeHTML Rev>.<Windows Build>"
    user_agent_3 = "Mozilla/5.0 (compatible; MSIE 9.0; AOL 9.7; AOLBuild 4343.19; Windows NT 6.1; WOW64; Trident/5.0; FunWebProducts)"
    user_agent_4 = "Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3"
    create_payload_requests_with_associations(user_agent: user_agent_1)
    create_payload_requests_with_associations(user_agent: user_agent_3)
    create_payload_requests_with_associations(user_agent: user_agent_4)
    create_payload_requests_with_associations(user_agent: user_agent_3)
    create_payload_requests_with_associations(user_agent: user_agent_4)
    create_payload_requests_with_associations(user_agent: user_agent_3)
    create_payload_requests_with_associations(user_agent: user_agent_4)
    create_payload_requests_with_associations(user_agent: user_agent_1)
    create_payload_requests_with_associations(user_agent: user_agent_2)
    create_payload_requests_with_associations(user_agent: user_agent_4)

    url_request = UrlRequest.find_by(url: 'http://jumpstartlab.com/blog')
    user_agents = url_request.three_most_popular_user_agents

    assert_equal ["Netscape, Windows XP", "AOL, Windows 7", "Chrome, Mac OS X 10.8.2"], user_agents
  end
end
