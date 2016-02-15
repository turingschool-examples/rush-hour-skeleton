require_relative '../test_helper'

class ClientCanViewEventTest < FeatureTest
  include TestHelpers

  def test_client_can_click_event_to_see_event_page
    client = Client.create(identifier: "jumpstartlab", root_url: "http://www.jumpstartlab.com")

    client.payload_requests.create(requested_at: "2013-02-16 21:38:28 -0700",
                                   responded_in: 35,
                                   event_name: "socialLogin")

    visit '/sources/jumpstartlab/events'

    assert page.has_content? 'socialLogin'

    click_link 'socialLogin'

    assert_equal '/sources/jumpstartlab/events/socialLogin', current_path
  end

  def test_client_can_see_event_data_by_hour
    client = Client.create(identifier: "jumpstartlab", root_url: "http://www.jumpstartlab.com")

    client.payload_requests.create(requested_at: "2013-02-16 21:38:28 -0700", responded_in: 35, event_name: "socialLogin")

    visit '/sources/jumpstartlab/events/socialLogin'

    assert page.has_content? 'socialLogin'
    assert page.has_content? '1'
    assert page.has_content? '21:00'

    client.payload_requests.create(requested_at: "2012-02-16 21:38:28 -0700", responded_in: 35, event_name: "socialLogin")

    visit '/sources/jumpstartlab/events/socialLogin'

    assert page.has_content? '2'
    assert page.has_content? '21:00'

    client.payload_requests.create(requested_at: "2012-02-16 20:38:28 -0700", responded_in: 35, event_name: "socialLogin")

    visit '/sources/jumpstartlab/events/socialLogin'

    assert page.has_content? '1'
    assert page.has_content? '20:00'
  end

  def test_client_can_see_total_for_event
    client = Client.create(identifier: "jumpstartlab", root_url: "http://www.jumpstartlab.com")

    client.payload_requests.create(requested_at: "2013-02-16 21:38:28 -0700", responded_in: 35, event_name: "socialLogin")

    visit '/sources/jumpstartlab/events/socialLogin'

    assert page.has_content? "Total: 1"

    client.payload_requests.create(requested_at: "2012-02-16 21:38:28 -0700", responded_in: 35, event_name: "socialLogin")

    visit '/sources/jumpstartlab/events/socialLogin'

    assert page.has_content? "Total: 2"
  end

  def test_error_message_with_link_for_undefined_client_event
    client = Client.create(identifier: "jumpstartlab", root_url: "http://www.jumpstartlab.com")

    client.payload_requests.create(requested_at: "2013-02-16 21:38:28 -0700", responded_in: 35, event_name: "socialLogin")

    visit '/sources/jumpstartlab/events/startedRegistration'

    assert '/sources/jumpstartlab/events/error', current_path
    assert page.has_content? "No event with 'startedRegistration' has been defined."
    assert page.has_link? 'Events Index'
  end
end
