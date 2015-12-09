require './test/test_helper'

class UserCanViewEventSpecificDetails < FeatureTest
  def register_turing_and_send_multiple_payloads
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 80,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginC",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginA",
      operating_system: "Macintosh",
      browser: "Safari",
      resolution: {width: "600", height: "800"},
      ip_address:"63.29.38.211"
    }

    payload_data_3 = {
      relative_path: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 50,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginA",
      operating_system: "Windows",
      browser: "IE10",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_4 = {
      relative_path: "/team",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 40,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginB",
      operating_system: "Windows",
      browser: "Chrome",
      resolution: {width: "1920", height: "1080"},
      ip_address:"63.29.38.211"
    }

    payload_data_5 = {
      relative_path: "/team",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 41,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginB",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_6 = {
      relative_path: "/about",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 5,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLoginB",
      operating_system: "Macintosh",
      browser: "Mozilla",
      resolution: {width: "1366", height: "768"},
      ip_address:"63.29.38.211"
    }

    payloads = [payload_data_1, payload_data_2, payload_data_3,
                payload_data_4, payload_data_5, payload_data_6]

    app = TrafficSpy::Application.find_by(identifier: "turing")

    payloads.each do |data|
      app.payloads.create(data)
    end
  end

  def test_user_can_view_details_from_event_social_login_A
    register_turing_and_send_multiple_payloads

    visit '/sources/turing/events/socialLoginA'

    

    # As a registered user,
    # When I visit '/sources/MY_ID/events/EVENTNAME',
    # And EVENTNAME has been defined,
    # Then I see the hour by hour breakdown of when the event was received. How many were shown at noon? at 1pm? at 2pm? Do it for all 24 hours.,
    # And I see how many times it was recieved overall
  end
end
