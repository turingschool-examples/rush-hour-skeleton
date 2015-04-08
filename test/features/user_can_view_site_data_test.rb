require './test/test_helper'

class UserViewsSiteDataTest < FeatureTest

  def test_user_views_identifier
    source = Source.create(root_url: "http://www.jumpstartlab.com", identifier: "jumpstartlab")
    Payload.new(
      url: "http://jumpstartlab.com/blog",
      requested_at: "2014-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://jumpstartlab.com",
      request_type: "GET",
      parameters:[],
      event_name: "socialLogin",
      user_agent: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      resolution_width: "1920",
      resolution_height:"1280",
      ip: "63.29.38.211"
      )
    Payload.new(
      url: "http://jumpstartlab.com/blog",
      requested_at: "2013-02-16 22:38:28 -0800",
      responded_in: 37,
      referred_by: "http://jumpstartlab.com",
      request_type: "GET",
      parameters:[],
      event_name: "socialLogin",
      user_agent: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      resolution_width: "1920",
      resolution_height:"1280",
      ip: "63.29.38.211"
      )
    Payload.new(
      url: "http://jumpstartlab.com/courses",
      requested_at: "2013-03-15 22:38:28 -0800",
      responded_in: 37,
      referred_by: "http://jumpstartlab.com",
      request_type: "GET",
      parameters:[],
      event_name: "socialLogin",
      user_agent: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      resolution_width: "1920",
      resolution_height:"1280",
      ip: "63.29.38.211"
      )
    #as a client
    #When I visit the page for my site
    visit '/sources/jumpstartlab'
    #I expect to see the identifier for my site
    assert page.has_content?("jumpstartlab")
  end
end