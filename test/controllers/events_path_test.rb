require_relative '../test_helper'

class EventsPathTest < ControllerTest

  def test_events_redirects_to_generic_error_page

    get '/sources/identifier_not_in_database/events', @raw_payload
    assert_equal true, last_response.redirect?

    follow_redirect!
    assert_equal "http://example.org/not_found", last_request.url
  end

  def test_events_page_opens_when_user_registered
    identifier = 'facebook'
    expected_path = "/sources/#{identifier}/events"
    post '/sources', { 'identifier' => identifier, 'rootUrl' => 'http://facebook.com' }

    get "/sources/#{identifier}/events", @raw_payload

    assert_equal 200, last_response.status
    assert_equal expected_path, last_request.path
  end
end
