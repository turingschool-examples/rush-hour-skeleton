require './test/test_helper'

class ViewStatTest < ControllerTest
  def populate
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data
    post '/sources/jumpstartlab/data', payload_data_two
    post '/sources/jumpstartlab/data', payload_data_three
  end

  def test_it_can_find_URLs_by_id
    populate
    assert_equal 1, TrafficSpy::URL.find(id = 1).id
    assert_equal 2, TrafficSpy::URL.find(id = 2).id
    assert_equal "http://jumpstartlab.com/blog", TrafficSpy::URL.find(id = 1).url
    assert_equal "http://jumpstartlab.com/test", TrafficSpy::URL.find(id = 2).url
    assert_equal "http://jumpstartlab.com/blog", TrafficSpy::URL.find(TrafficSpy::Payload.first.url_id).url
  end

  def test_it_counts_urls_for_max_and_min
    skip
    populate
    get '/sources/jumpstartlab'

    assert_equal '"http://jumpstartlab.com/blog"=>2, "http://jumpstartlab.com/test"=>1', 2
  end

  def test_it_can_find_browser
    populate
    get '/sources/jumpstartlab'

    assert_equal ["chrome", "opers"], TrafficSpy::Server.browsers

  end

  def test_it_can_find_most_reffered
    populate
    get "/sources/jumpstartlab/url/blog"


  end

  def test_it_can_find_most_reffered
    populate
    get "/sources/jumpstartlab/url/blog"
  end


  def payload_data
     {"payload" => {"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211" }.to_json }
  end

  def payload_data_two
     {"payload" => {"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":666,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "parameters":[],
      "eventName":"die with your boots on",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211" }.to_json }
  end

  def payload_data_three
     {"payload" => {"url":"http://jumpstartlab.com/test",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":666,
      "referredBy":"http://fancyboots.com",
      "requestType":"GET",
      "parameters":[],
      "eventName":"die with your boots on",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211" }.to_json }
  end
end
