require './test/test_helper'

class RegisterApplicationTest < ModelTest
  def test_initializes_with_identifier_and_root_url_and_creates_new_application
    params = { identifier: 'turing', rootUrl: 'http://turing.io' }
    register_app = TrafficSpy::RegisterApplication.new(params)

    assert_equal 'turing', register_app.identifier
    assert_equal 'http://turing.io', register_app.root_url
    assert_equal TrafficSpy::Application, register_app.application.class
  end

  def test_valid_params_returns_true_if_identifier_and_root_url_exist
    params = { identifier: 'turing', rootUrl: 'http://turing.io' }
    register_app = TrafficSpy::RegisterApplication.new(params)

    assert register_app.valid_params?
  end

  def test_valid_params_returns_false_if_no_identifier_exists
    params = { rootUrl: 'http://turing.io' }
    register_app = TrafficSpy::RegisterApplication.new(params)

    refute register_app.valid_params?
  end

  def test_valid_params_returns_false_if_no_root_url_exists
    params = { identifier: 'turing' }
    register_app = TrafficSpy::RegisterApplication.new(params)

    refute register_app.valid_params?
  end

  def test_error_message_responds_with_identifier_cant_be_blank_if_no_identifier
    params = { rootUrl: 'http://turing.io' }
    register_app = TrafficSpy::RegisterApplication.new(params)
    register_app.application.save

    expected = "Identifier can't be blank"

    assert_equal expected, register_app.error_message
  end

  def test_error_message_responds_with_root_url_cant_be_blank_if_no_root_url
    params = { identifier: 'turing'  }
    register_app = TrafficSpy::RegisterApplication.new(params)
    register_app.application.save

    expected = "Root url can't be blank"

    assert_equal expected, register_app.error_message
  end

  def test_error_message_responds_with_identifier_already_taken_if_id_already_exists
    params = { identifier: 'turing', rootUrl: 'http://turing.io' }
    register_app1 = TrafficSpy::RegisterApplication.new(params)
    register_app1.application.save
    register_app2 = TrafficSpy::RegisterApplication.new(params)
    register_app2.application.save

    expected = "Identifier has already been taken"

    assert_equal expected, register_app2.error_message
  end

  def test_save_returns_200_status_and_body_for_valid_parameters
    params = { identifier: 'turing', rootUrl: 'http://turing.io' }
    register_app = TrafficSpy::RegisterApplication.new(params)

    assert_equal [200, { identifier: 'turing' }.to_json], register_app.save
  end

  def test_save_returns_403_status_and_body_for_duplicate_registration
    params = { identifier: 'turing', rootUrl: 'http://turing.io' }
    register_app1 = TrafficSpy::RegisterApplication.new(params)
    register_app1.application.save
    register_app2 = TrafficSpy::RegisterApplication.new(params)

    expected = "Identifier has already been taken"

    assert_equal [403, expected], register_app2.save
  end

  def test_save_returns_400_status_and_body_for_no_identifier
    params = { rootUrl: 'http://turing.io' }
    register_app = TrafficSpy::RegisterApplication.new(params)

    assert_equal [400, "Identifier can't be blank"], register_app.save
  end

  def test_save_returns_400_status_and_body_for_no_root_url
    params = { identifier: 'turing' }
    register_app = TrafficSpy::RegisterApplication.new(params)

    assert_equal [400, "Root url can't be blank"], register_app.save
  end
end
