require_relative '../test_helper'

class EventDetailsPageTest < FeatureTest

  def create_source(identifier)
    Source.create({identifier: identifier, root_url: "http://#{identifier}.com" })
  end

  def test_it_displays_screen_resolution_breakdown
    create_source("jumpstartlab")
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", resolution_width: "1920", resolution_height: "1280", requested_at: "2013-02-16 21:38:28 -0799"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", resolution_width: "800", resolution_height: "600", requested_at: "2013-02-16 21:38:28 -0702"})

    visit '/sources/jumpstartlab'
    assert page.has_content?("Screen Resolution Breakdown")
    assert page.has_content?("1920 x 1280: 1")
    assert page.has_content?("800 x 600: 1")
  end

  def test_it_displays_hourly_breakdown
    create_source("jumpstartlab")
    Payload.create({source_id: 1, event_name: "socialLogin", requested_at: "2013-02-16 21:38:28 -0701"})
    Payload.create({source_id: 1, event_name: "socialLogin", requested_at: "2013-02-16 21:38:28 -0702"})

    visit '/sources/jumpstartlab/events/socialLogin'
    assert page.has_content?("socialLogin")
    assert page.has_content?("Hour by Hour Breakdown")
    assert page.has_content?("Times Received")
  end

  def test_it_has_a_link_to_return_to_events_index
    create_source("jumpstartlab")
    Payload.create({source_id: 1, event_name: "socialLogin", requested_at: "2013-02-16 21:38:28 -0701"})
    Payload.create({source_id: 1, event_name: "socialLogin", requested_at: "2013-02-16 21:38:28 -0702"})

    visit '/sources/jumpstartlab/events/socialLogin'
    assert page.has_link?("Return to Events Index")
  end
end
