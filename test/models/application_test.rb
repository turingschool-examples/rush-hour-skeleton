require './test/test_helper'

class ApplicationTest < ModelTest
  def test_can_create_application_with_valid_parameters
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")

    assert_equal 1, TrafficSpy::Application.count
    assert_equal 'turing', TrafficSpy::Application.first.identifier
    assert_equal 'http://turing.io', TrafficSpy::Application.first.root_url
  end

  def test_cannot_create_application_without_identifier
    TrafficSpy::Application.create(root_url: "http://turing.io")

    assert_equal 0, TrafficSpy::Application.count
  end

  def test_cannot_create_application_without_root_url
    TrafficSpy::Application.create(identifier: "turing")

    assert_equal 0, TrafficSpy::Application.count
  end

  def test_cannot_register_the_same_application_twice
    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")
    assert_equal 1, TrafficSpy::Application.count

    TrafficSpy::Application.create(identifier: "turing", root_url: "http://turing.io")
    assert_equal 1, TrafficSpy::Application.count
  end

  def test_relative_path_requests
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = {"/blog" => 3, "/team" => 2, "/about" => 1}

    assert_equal expected, app.relative_path_requests
  end

  def test_browser_requests
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = {"Chrome" => 3, "Mozilla" => 1, "IE10" => 1, "Safari" => 1}

    assert_equal expected, app.browser_requests
  end

  def test_operating_systems_requests
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    expected = {"Macintosh" => 4, "Windows" => 2}

    assert_equal expected, app.operating_system_requests
  end

  def test_resolution_requests
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')

    result = app.resolution_requests

    assert_equal 3, result[[1920, 1280]]
    assert_equal 1, result[[1366, 768]]
    assert_equal 1, result[[1920, 1080]]
    assert_equal 1, result[[600, 800]]
  end



  def test_average_response_times
    register_turing_and_send_multiple_payloads

    app = TrafficSpy::Application.find_by(identifier: 'turing')
    result = app.average_response_times

    assert_equal "/blog", result[0][0]
    assert_equal 55.67, result[0][1].to_f.round(2)
    assert_equal "/team", result[1][0]
    assert_equal 40.5, result[1][1].to_f.round(2)
    assert_equal "/about", result[2][0]
    assert_equal 25.0, result[2][1].to_f.round(2)
  end
end
