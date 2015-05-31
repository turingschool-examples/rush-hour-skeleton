require_relative '../test_helper'

class ViewingEventsTest < FeatureTest

  def create_source(identifier)
    Source.create({identifier: identifier, root_url: "http://#{identifier}.com" })
  end

  def json(identifier)
    { :url=>              "http://#{identifier}.com/blog",
      :requestedAt=>      "2013-02-16 21:38:28 -0700",
      :respondedIn=>      37,
      :referredBy=>       "http://#{identifier}.com",
      :requestType=>      "GET",
      :parameters=>       [],
      :eventName=>        "socialLogin",
      :userAgent=>        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      :resolutionWidth=>  "1920",
      :resolutionHeight=> "1280",
      :ip=>               "63.29.38.211"
    }.to_json
  end

  def create_payload(identifier)
    PayloadCreator.new(json(identifier), identifier)
  end

  def test_it_displays_events
    create_source("yahoo")
    create_payload ("yahoo")
    
    visit '/sources/yahoo/events'
    assert page.has_content?("socialLogin: 1")
    refute page.has_content?("You have no events!")
  end

  def test_it_knows_when_no_events_exists
    create_source("yahoo")
    
    visit '/sources/yahoo/events'
    assert page.has_content?("You have no events!")
  end
end
