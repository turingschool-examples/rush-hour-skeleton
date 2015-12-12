require './test/test_helper'

class PayloadTest < ModelTest
  def load_data(payload_data)
    app = TrafficSpy::Application.find_by(identifier: "turing")

    data = TrafficSpy::DataLoader.new(payload_data).find_ids
    data[:application_id] = app.id

    TrafficSpy::Payload.create(data)
  end

  def load_two_payloads(payload_data_1, payload_data_2)
    load_data(payload_data_1)
    load_data(payload_data_2)
  end

  def create_two_different_payloads
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/about",
      requested_at: "2013-02-17 21:38:28 -0700",
      responded_in: 40,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }
    load_two_payloads(payload_data_1, payload_data_2)
  end

  def test_can_create_payload_and_associate_app_path_reqtype_res_os_broswer_event_with_valid_parameters
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }

    app = TrafficSpy::Application.find_by(identifier: "turing")
    payload_data[:application_id] = app.id

    rel_path = TrafficSpy::RelativePath.find_or_create_by(path: payload_data[:relative_path_string])
    payload_data[:relative_path_id] = rel_path.id

    req_type = TrafficSpy::RequestType.find_or_create_by(verb: payload_data[:request_type_string])
    payload_data[:request_type_id] = req_type.id

    resolution = TrafficSpy::Resolution.find_or_create_by(width: payload_data[:resolution_string][:width],
                                                          height: payload_data[:resolution_string][:height])
    payload_data[:resolution_id] = resolution.id

    operating_system = TrafficSpy::OperatingSystem.find_or_create_by(op_system: payload_data[:operating_system_string])
    payload_data[:operating_system_id] = operating_system.id

    browser = TrafficSpy::Browser.find_or_create_by(browser_name: payload_data[:browser_string])
    payload_data[:browser_id] = browser.id

    event = TrafficSpy::Event.find_or_create_by(event_name: payload_data[:event_string])
    payload_data[:event_id] = event.id

    [:relative_path_string, :request_type_string, :resolution_string,
     :operating_system_string, :browser_string, :event_string].each { |k| payload_data.delete(k) }

    TrafficSpy::Payload.create(payload_data)

    assert_equal 1, TrafficSpy::Payload.count
    assert_equal 1, TrafficSpy::Payload.first.application_id

    assert_equal 1, TrafficSpy::Payload.first.relative_path_id
    assert_equal '/blog', TrafficSpy::Payload.first.relative_path.path

    assert_equal 1, TrafficSpy::Payload.first.request_type_id
    assert_equal 'GET', TrafficSpy::Payload.first.request_type.verb

    assert_equal 1, TrafficSpy::Payload.first.resolution_id
    assert_equal 1920, TrafficSpy::Payload.first.resolution.width
    assert_equal 1280, TrafficSpy::Payload.first.resolution.height

    assert_equal 1, TrafficSpy::Payload.first.operating_system_id
    assert_equal 'Macintosh', TrafficSpy::Payload.first.operating_system.op_system

    assert_equal 1, TrafficSpy::Payload.first.browser_id
    assert_equal 'Chrome', TrafficSpy::Payload.first.browser.browser_name

    assert_equal 1, TrafficSpy::Payload.first.event_id
    assert_equal 'socialLogin', TrafficSpy::Payload.first.event.event_name

    assert_equal DateTime.new(2013,02,16,21,38,28, '-0700'), TrafficSpy::Payload.first.requested_at
    assert_equal 37, TrafficSpy::Payload.first.responded_in
    assert_equal 'http://turing.io', TrafficSpy::Payload.first.referred_by
    assert_equal '63.29.38.211', TrafficSpy::Payload.first.ip_address
  end

  def test_can_create_and_associate_two_payloads_with_valid_unique_parameters
    create_two_different_payloads

    assert_equal 2, TrafficSpy::Payload.count

    assert_equal 1, TrafficSpy::Payload.first.application_id
    assert_equal '/blog', TrafficSpy::Payload.first.relative_path.path
    assert_equal DateTime.new(2013,02,16,21,38,28, '-0700'), TrafficSpy::Payload.first.requested_at
    assert_equal 37, TrafficSpy::Payload.first.responded_in

    assert_equal 1, TrafficSpy::Payload.last.application_id
    assert_equal '/about', TrafficSpy::Payload.last.relative_path.path
    assert_equal DateTime.new(2013,02,17,21,38,28, '-0700'), TrafficSpy::Payload.last.requested_at
    assert_equal 40, TrafficSpy::Payload.last.responded_in
  end

  def test_cannot_create_two_payloads_with_exactly_idential_parameters
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }
    app = TrafficSpy::Application.find_by(identifier: "turing")

    data = TrafficSpy::DataLoader.new(payload_data).find_ids
    data[:application_id] = app.id

    TrafficSpy::Payload.create(data)
    assert_equal 1, TrafficSpy::Payload.count

    TrafficSpy::Payload.create(data)
    assert_equal 1, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_application_id
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")
    TrafficSpy::Application.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app_turing = TrafficSpy::Application.find_by(identifier: "turing")
    app_jumpstartlab = TrafficSpy::Application.find_by(identifier: "jumpstartlab")

    data_turing = TrafficSpy::DataLoader.new(payload_data).find_ids
    data_turing[:application_id] = app_turing.id

    data_jumpstartlab = TrafficSpy::DataLoader.new(payload_data).find_ids
    data_jumpstartlab[:application_id] = app_jumpstartlab.id

    TrafficSpy::Payload.create(data_turing)
    assert_equal 1, TrafficSpy::Payload.count

    TrafficSpy::Payload.create(data_jumpstartlab)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_relative_path
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/team",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }
    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_requested_at_time
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2014-03-25 20:40:13 -0800",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_responded_in
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 80,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_referred_by
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://facebook.com",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_request_type_string
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"POST",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_event
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialShare",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_operating_system_string
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Windows",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_browser
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Safari",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_resolution_string
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "600", height: "800"},
      ip_address:"63.29.38.211"
    }

    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_ip_address
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"99.06.12.836"
    }

    load_two_payloads(payload_data_1, payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count
  end
end
