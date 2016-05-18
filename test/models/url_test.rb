require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_pull_associated_verbs
    url = Url.find(@url.id)
    assert_equal ["GET"], url.associated_verbs
  end

  def test_it_can_pull_three_most_popular_referrers
    id_1 = Referrer.create({:name => "http://jumpstartlab.com/test1"})
    id_2 = Referrer.create({:name => "http://jumpstartlab.com/test2"})
    id_3 = Referrer.create({:name => "http://jumpstartlab.com/test3"})

    @payload = PayloadRequest.create({
      :url_id => @url.id,
      :referrer_id => id_1.id,
      :request_type_id => @request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => @event_name.id,
      :user_agent_id => @user_agent.id,
      :responded_in => 37,
      :parameters => [],
      :ip_id => @ip.id,
      :resolution_id => @resolution.id
      })

    @payload = PayloadRequest.create({
      :url_id => @url.id,
      :referrer_id => id_2.id,
      :request_type_id => @request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => @event_name.id,
      :user_agent_id => @user_agent.id,
      :responded_in => 37,
      :parameters => [],
      :ip_id => @ip.id,
      :resolution_id => @resolution.id
      })

    @payload = PayloadRequest.create({
      :url_id => @url.id,
      :referrer_id => id_2.id,
      :request_type_id => @request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => @event_name.id,
      :user_agent_id => @user_agent.id,
      :responded_in => 37,
      :parameters => [],
      :ip_id => @ip.id,
      :resolution_id => @resolution.id
      })

    @payload = PayloadRequest.create({
      :url_id => @url.id,
      :referrer_id => id_3.id,
      :request_type_id => @request_type.id,
      :requested_at => "2013-02-16 21:38:28 -0700",
      :event_name_id => @event_name.id,
      :user_agent_id => @user_agent.id,
      :responded_in => 37,
      :parameters => [],
      :ip_id => @ip.id,
      :resolution_id => @resolution.id
      })

    url = Url.find(@url.id)

    assert_equal [], url.top_three_referrers
  end
end
