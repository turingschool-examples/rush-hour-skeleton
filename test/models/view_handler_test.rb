require_relative '../test_helper'

class ViewHandlerTest < Minitest::Test

  def payload
    {"payload"=>
    "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
   "splat"=>[],
   "captures"=>["jumpstartlab"],
   "identifier"=>"jumpstartlabs"}
  end

  def no_event_name_payload
    {"payload"=>
    "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
   "splat"=>[],
   "captures"=>["jumpstartlab"],
   "identifier"=>"jumpstartlabs"}
  end

  def test_view_handler_assigns_erb_correctly_for_application_details
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    ph = PayloadHandler.new(payload)
    found_client = Client.find_by(name: "jumpstartlabs")

    assert_equal :application_details, ViewHandler.assign_application_details_erb_path(client)
  end

  def test_view_handler_assigns_erb_correctly_for_application_details_sad_path
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    found_client = Client.find_by(name: "jumpstartlabs")

    assert_equal :error, ViewHandler.assign_application_details_erb_path(found_client)
    assert_equal "No payload data has been received for this source.", ViewHandler.assign_application_details_error_message(found_client)
  end

  def test_view_handler_assigns_application_details_error_message_and_erb_path_correctly_for_missing_identifier
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    found_client = Client.find_by(name: "pretzels")

    assert_equal :error, ViewHandler.assign_application_details_erb_path(found_client)
    assert_equal "The identifier does not exist.", ViewHandler.assign_application_details_error_message(found_client)
  end

  def test_view_handler_assigns_url_details_erb_path_for_valid_path
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    ph = PayloadHandler.new(payload)
    path = client.payloads.pluck(:path).first

    assert_equal :url_details, ViewHandler.assign_url_details_erb_path(path)
  end

  def test_view_handler_assigns_url_details_erb_path_for_sad_path
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    ph = PayloadHandler.new(payload)

    assert_equal :error, ViewHandler.assign_url_details_erb_path("pretzels")
    assert_equal "That URL has not been requested.", ViewHandler.assign_url_details_error_message("pretzels")
  end

  def test_view_handler_assigns_event_index_erb_for_sad_path
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")

    assert_equal :error, ViewHandler.assign_events_index_erb_path(client)
    assert_equal "No events have been defined.", ViewHandler.assign_events_index_error_message(client)
  end

  def test_view_handler_assigns_event_index_erb_for_happy_path
    client = Client.create(name: "jumpstartlabs", root_url: "test.com")
    ph = PayloadHandler.new(payload)

    assert_equal :events_index, ViewHandler.assign_events_index_erb_path(client)
  end

end
