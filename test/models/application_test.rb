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
end
