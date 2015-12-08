require './test/test_helper'

class RegisterApplicationTest < ModelTest
  def test_initializes_with_identifier_and_root_url_and_creates_new_application
    params = { identifier: 'turing', rootUrl: 'http://turing.io' }
    register_app = TrafficSpy::RegisterApplication.new(params)

    assert_equal 'turing', register_app.identifier
    assert_equal 'http://turing.io', register_app.root_url
    assert_equal TrafficSpy::Application, register_app.application.class
  end
end
