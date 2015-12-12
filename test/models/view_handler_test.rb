require_relative '../test_helper'

class ViewHandlerTest < Minitest::Test

  def payload
    {"payload"=>
    "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
   "splat"=>[],
   "captures"=>["jumpstartlab"],
   "identifier"=>"jumpstartlabs"}
  end

  def test_view_handler_assigns_erb_correctly_for_application_details
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    ph = PayloadHandler.new(payload)
    found_client = Client.find_by(name: "jumpstartlabs")
    # vh = ViewHandler.new(found_client)

    assert_equal :application_details, ViewHandler.assign_application_details_erb_path(client)
  end

  def test_view_handler_assigns_erb_correctly_for_sad_path
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    found_client = Client.find_by(name: "jumpstartlabs")
    # vh = ViewHandler.new(found_client)

    assert_equal :error, ViewHandler.assign_application_details_erb_path(found_client)
    assert_equal "No payload data has been received for this source.", ViewHandler.assign_application_details_error_message(found_client)
  end

  def test_view_handler_assigns_error_message_and_erb_path_correctly_for_missing_identifier
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    found_client = Client.find_by(name: "pretzels")
    # ViewHandler = ViewHandler.new(found_client)

    assert_equal :error, ViewHandler.assign_application_details_erb_path(found_client)
    assert_equal "The identifier does not exist.", ViewHandler.assign_application_details_error_message(found_client)
  end

end
