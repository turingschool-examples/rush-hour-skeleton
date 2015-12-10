require './test/test_helper'

class PayloadTest < ModelTest
  def test_can_create_payload_with_valid_parameters
    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }
    TrafficSpy::Payload.create(payload_data)

    assert_equal 1, TrafficSpy::Payload.count
    assert_nil TrafficSpy::Payload.first.application_id
    assert_equal '/blog', TrafficSpy::Payload.first.relative_path_string
    assert_equal DateTime.new(2013,02,16,21,38,28, '-0700'), TrafficSpy::Payload.first.requested_at
    assert_equal 37, TrafficSpy::Payload.first.responded_in
    assert_equal 'http://turing.io', TrafficSpy::Payload.first.referred_by
    assert_equal 'GET', TrafficSpy::Payload.first.request_type
    assert_equal 'socialLogin', TrafficSpy::Payload.first.event
    assert_equal 'Macintosh', TrafficSpy::Payload.first.operating_system
    assert_equal 'Chrome', TrafficSpy::Payload.first.browser
    assert_equal '{:width=>"1920", :height=>"1280"}', TrafficSpy::Payload.first.resolution
    assert_equal '63.29.38.211', TrafficSpy::Payload.first.ip_address
  end

  def test_can_create_and_associate_payload_with_valid_parameters
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }

    app = TrafficSpy::Application.find_by(identifier: "turing")
    app.payloads.create(payload_data)

    assert_equal 1, TrafficSpy::Payload.count
    assert_equal 1, TrafficSpy::Payload.first.application_id
    assert_equal '/blog', TrafficSpy::Payload.first.relative_path_string
    assert_equal DateTime.new(2013,02,16,21,38,28, '-0700'), TrafficSpy::Payload.first.requested_at
    assert_equal 37, TrafficSpy::Payload.first.responded_in
    assert_equal 'http://turing.io', TrafficSpy::Payload.first.referred_by
    assert_equal 'GET', TrafficSpy::Payload.first.request_type
    assert_equal 'socialLogin', TrafficSpy::Payload.first.event
    assert_equal 'Macintosh', TrafficSpy::Payload.first.operating_system
    assert_equal 'Chrome', TrafficSpy::Payload.first.browser
    assert_equal '{:width=>"1920", :height=>"1280"}', TrafficSpy::Payload.first.resolution
    assert_equal '63.29.38.211', TrafficSpy::Payload.first.ip_address
  end

  def test_can_create_payload_and_associate_app_and_path_with_valid_parameters
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
      }

    app = TrafficSpy::Application.find_by(identifier: "turing")
    rel_path = TrafficSpy::RelativePath.find_or_create_by(path: payload_data[:relative_path_string])
    payload_data[:relative_path_id] = rel_path.id
    payload_data[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data)

    assert_equal 1, TrafficSpy::Payload.count
    assert_equal 1, TrafficSpy::Payload.first.application_id

    assert_equal '/blog', TrafficSpy::Payload.first.relative_path_string
    assert_equal 1, TrafficSpy::Payload.first.relative_path_id
    assert_equal '/blog', TrafficSpy::Payload.first.relative_path.path

    assert_equal DateTime.new(2013,02,16,21,38,28, '-0700'), TrafficSpy::Payload.first.requested_at
    assert_equal 37, TrafficSpy::Payload.first.responded_in
    assert_equal 'http://turing.io', TrafficSpy::Payload.first.referred_by
    assert_equal 'GET', TrafficSpy::Payload.first.request_type
    assert_equal 'socialLogin', TrafficSpy::Payload.first.event
    assert_equal 'Macintosh', TrafficSpy::Payload.first.operating_system
    assert_equal 'Chrome', TrafficSpy::Payload.first.browser
    assert_equal '{:width=>"1920", :height=>"1280"}', TrafficSpy::Payload.first.resolution
    assert_equal '63.29.38.211', TrafficSpy::Payload.first.ip_address
  end

  def test_can_create_and_associate_two_payloads_with_valid_unique_parameters
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/about",
      requested_at: "2013-02-17 21:38:28 -0700",
      responded_in: 40,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    assert_equal 0, TrafficSpy::Payload.count

    rel_path = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)

    assert_equal 1, TrafficSpy::Payload.count

    rel_path = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)

    assert_equal 2, TrafficSpy::Payload.count

    assert_equal 1, TrafficSpy::Payload.first.application_id
    assert_equal '/blog', TrafficSpy::Payload.first.relative_path_string
    assert_equal DateTime.new(2013,02,16,21,38,28, '-0700'), TrafficSpy::Payload.first.requested_at
    assert_equal 37, TrafficSpy::Payload.first.responded_in

    assert_equal 1, TrafficSpy::Payload.last.application_id
    assert_equal '/about', TrafficSpy::Payload.last.relative_path_string
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
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }
    app = TrafficSpy::Application.find_by(identifier: "turing")
    rel_path = TrafficSpy::RelativePath.find_or_create_by(path: payload_data[:relative_path_string])
    payload_data[:relative_path_id] = rel_path.id
    payload_data[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data)
    assert_equal 1, TrafficSpy::Payload.count

    TrafficSpy::Payload.create(payload_data)
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
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app_turing = TrafficSpy::Application.find_by(identifier: "turing")
    app_jumpstartlab = TrafficSpy::Application.find_by(identifier: "jumpstartlab")

    rel_path = TrafficSpy::RelativePath.find_or_create_by(path: payload_data[:relative_path_string])
    payload_data[:relative_path_id] = rel_path.id

    payload_data[:application_id] = app_turing.id
    TrafficSpy::Payload.create(payload_data)

    assert_equal 1, TrafficSpy::Payload.count

    payload_data[:application_id] = app_jumpstartlab.id
    TrafficSpy::Payload.create(payload_data)

    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_relative_path
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/team",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_requested_at_time
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2014-03-25 20:40:13 -0800",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_responded_in
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 80,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_referred_by
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://facebook.com",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_request_type
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"POST",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_event
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialShare",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_operating_system
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Windows",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_browser
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Safari",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_resolution
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "600", height: "800"},
      ip_address:"63.29.38.211"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_creates_second_payload_with_only_unique_ip_address
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    payload_data_1 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }

    payload_data_2 = {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type:"GET",
      event: "socialLogin",
      operating_system: "Macintosh",
      browser: "Chrome",
      resolution: {width: "1920", height: "1280"},
      ip_address:"99.06.12.836"
    }

    app = TrafficSpy::Application.find_by(identifier: "turing")

    rel_path_1 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_1[:relative_path_string])
    payload_data_1[:relative_path_id] = rel_path_1.id
    payload_data_1[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_1)
    assert_equal 1, TrafficSpy::Payload.count

    rel_path_2 = TrafficSpy::RelativePath.find_or_create_by(path: payload_data_2[:relative_path_string])
    payload_data_2[:relative_path_id] = rel_path_2.id
    payload_data_2[:application_id] = app.id

    TrafficSpy::Payload.create(payload_data_2)
    assert_equal 2, TrafficSpy::Payload.count
  end

  def test_group_count_and_order_relative_path
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = {"/blog" => 3, "/team" => 2, "/about" => 1}

    assert_equal expected, app.payloads.group_count_and_order_relative_path
  end

  def test_group_count_and_order_browser
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = {"Chrome" => 3, "Mozilla" => 1, "IE10" => 1, "Safari" => 1}

    assert_equal expected, app.payloads.group_count_and_order(:browser)
  end

  def test_group_count_and_order_operating_system
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = {"Macintosh" => 4, "Windows" => 2}

    assert_equal expected, app.payloads.group_count_and_order(:operating_system)
  end

  def test_group_count_and_order_resolution
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = {'{:width=>"1920", :height=>"1280"}' => 3,
                '{:width=>"1366", :height=>"768"}' => 1,
                '{:width=>"1920", :height=>"1080"}' => 1,
                '{:width=>"600", :height=>"800"}' => 1}

    assert_equal expected, app.payloads.group_count_and_order(:resolution)
  end

  def test_group_average_and_order_response_times
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    result = app.payloads.group_average_and_order_response_times

    assert_equal "/blog", result[0][0]
    assert_equal 55.67, result[0][1].to_f.round(2)
    assert_equal "/team", result[1][0]
    assert_equal 40.5, result[1][1].to_f.round(2)
    assert_equal "/about", result[2][0]
    assert_equal 25.0, result[2][1].to_f.round(2)
  end

  def test_matching_by_relative_path
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')

    assert_equal 6, app.payloads.count

    app_blog_payloads = app.payloads.matching("/blog")
    assert_equal 3, app_blog_payloads.count

    app_blog_team = app.payloads.matching("/team")
    assert_equal 2, app_blog_team.count

    app_blog_about = app.payloads.matching("/about")
    assert_equal 1, app_blog_about.count
  end

  def test_max_response_time
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')

    app_blog_payloads = app.payloads.matching("/blog")
    assert_equal 80, app_blog_payloads.max_response_time

    app_blog_team = app.payloads.matching("/team")
    assert_equal 41, app_blog_team.max_response_time

    app_blog_about = app.payloads.matching("/about")
    assert_equal 25, app_blog_about.max_response_time
  end

  def test_min_response_time
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')

    app_blog_payloads = app.payloads.matching("/blog")
    assert_equal 37, app_blog_payloads.min_response_time

    app_blog_team = app.payloads.matching("/team")
    assert_equal 40, app_blog_team.min_response_time

    app_blog_about = app.payloads.matching("/about")
    assert_equal 25, app_blog_about.min_response_time
  end

  def test_avg_response_time
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')

    app_blog_payloads = app.payloads.matching("/blog")
    assert_equal 55.67, app_blog_payloads.avg_response_time

    app_blog_team = app.payloads.matching("/team")
    assert_equal 40.5, app_blog_team.avg_response_time

    app_blog_about = app.payloads.matching("/about")
    assert_equal 25, app_blog_about.avg_response_time
  end

  def test_get_top_3_relative_path
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = [["/blog", 3], ["/team", 2], ["/about", 1]]

    assert_equal expected, app.payloads.get_top_3_relative_path
  end

  def test_get_top_3_browser
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = [["Chrome", 3], ["IE10", 1], ["Mozilla", 1]]

    assert_equal expected, app.payloads.get_top_3(:browser)
  end

  def test_get_top_3_operating_system
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = [["Macintosh", 4], ["Windows", 2]]

    assert_equal expected, app.payloads.get_top_3(:operating_system)
  end

  def test_get_top_3_resolution
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = [['{:width=>"1920", :height=>"1280"}', 3],
                ['{:width=>"1366", :height=>"768"}', 1],
                ['{:width=>"1920", :height=>"1080"}', 1]]

    assert_equal expected, app.payloads.get_top_3(:resolution)
  end

  def test_requests_by_hour
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')

    assert_equal 0, app.payloads.requests_by_hour(0)
  end
end
