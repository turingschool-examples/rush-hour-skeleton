require_relative "../test_helper"

class UrlTest < Minitest::Test
  include TestHelpers

  def setup
    Url.create(address: "www.google.com")

    PayloadRequest.create({
                          :url_id=> 1,
                          :requested_at=> "2015-02-06",
                          :responded_in=> 50,
                          :referrer_id=> 1,
                          :request_id=> 1,
                          :parameters=> [],
                          :event_id=> "antisocialLogin",
                          :user_agent_b_id=> 1,
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })

    PayloadRequest.create({
                          :url_id=> 1,
                          :requested_at=> "2015-06-06",
                          :responded_in=> 100,
                          :referrer_id=> 1,
                          :request_id=> 2,
                          :parameters=> [],
                          :event_id=> "antisocialLogin",
                          :user_agent_b_id=> 1,
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })


    PayloadRequest.create({
                          :url_id=> 1,
                          :requested_at=> "2015-06-06",
                          :responded_in=> 100,
                          :referrer_id=> 2,
                          :request_id=> 2,
                          :parameters=> [],
                          :event_id=> "antisocialLogin",
                          :user_agent_b_id=> 2,
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })

    PayloadRequest.create({
                          :url_id=> 1,
                          :requested_at=> "2015-06-06",
                          :responded_in=> 100,
                          :referrer_id=> 3,
                          :request_id=> 2,
                          :parameters=> [],
                          :event_id=> "antisocialLogin",
                          :user_agent_b_id=> 3,
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })

    PayloadRequest.create({
                          :url_id=> 1,
                          :requested_at=> "2015-06-06",
                          :responded_in=> 100,
                          :referrer_id=> 3,
                          :request_id=> 2,
                          :parameters=> [],
                          :event_id=> "antisocialLogin",
                          :user_agent_b_id=> 2,
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })
  end

  def test_max_response_time
    url = Url.find(1)
    max = url.max_response_time

    assert_equal 100, max
  end

  def test_min_reponse_time
    url = Url.find(1)
    min = url.min_response_time

    assert_equal 50, min
  end

  def test_time_across_all_requests
    url = Url.find(1)
    range = url.response_times_across_all_requests

    assert_equal [100, 100, 100, 100, 50], url.response_times_across_all_requests
  end

  def test_average_response_time
    url = Url.find(1)
    average = url.average_response_time

    assert_equal 90, average
  end

  def test_http_verbs_associated_with_a_url
    verb1 = Request.create({:verb => "GET"})
    verb2 = Request.create({:verb => "POST"})

    url = Url.find(1)
    verbs = url.http_verbs_associated

    assert_equal ["GET", "POST"], verbs
  end

  def test_it_can_output_most_popular_referrers
    referrer1 = Referrer.create({:address => "www.google.com"})
    referrer2 = Referrer.create({:address => "www.yahoo.com"})
    referrer3 = Referrer.create({:address => "today.turing.io"})
    referrer4 = Referrer.create({:address => "www.nytimes.com"})
    url = Url.find(1)

    assert_equal ["today.turing.io", "www.google.com", "www.yahoo.com"], url.most_popular_referrers
  end

  def test_it_can_ouput_most_popular_user_agents
    user_agent1 = UserAgentB.create({:browser => "Chrome", :platform => "Macintosh"})
    user_agent2 = UserAgentB.create({:browser => "Chrome", :platform => "Windows"})
    user_agent3 = UserAgentB.create({:browser => "Firefox", :platform => "Macintosh"})
    user_agent4 = UserAgentB.create({:browser => "Chrome", :platform => "Linux"})
    url = Url.find(1)
    user_agents = url.most_popular_user_agents

    assert_equal [user_agent1, user_agent2, user_agent3], user_agents
  end



end
