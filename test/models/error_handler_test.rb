require_relative '../test_helper'

class ErrorHandlerTest < Minitest::Test

  def payload
    {"payload"=>
    "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
   "splat"=>[],
   "captures"=>["jumpstartlab"],
   "identifier"=>"jumpstartlabs"}
  end

  def test_can_instantiate_error_handler
    client = Client.create(name: "test", root_url: "test.com")
    eh = ErrorHandler.new(client)

    assert eh
  end

  def test_error_handler_assigns_erb_correctly_for_happy_path
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    ph = PayloadHandler.new(payload)
    found_client = Client.find_by(name: "jumpstartlabs")
    eh = ErrorHandler.new(found_client)

    assert_equal :application_details, eh.erb_path
  end

  def test_error_handler_assigns_erb_correctly_for_sad_path
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    found_client = Client.find_by(name: "jumpstartlabs")
    eh = ErrorHandler.new(found_client)

    assert_equal :error, eh.erb_path
    assert_equal "No payload data has been received for this source.", eh.error_message
  end

  def test_error_handler_assigns_error_message_and_erb_path_correctly_for_missing_identifier
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    found_client = Client.find_by(name: "pretzels")
    eh = ErrorHandler.new(found_client)

    assert_equal :error, eh.erb_path
    assert_equal "The identifier does not exist.", eh.error_message
  end

end
