require_relative '../test_helper'

class EventsDataTest < FeatureTest

  def test_user_sees_index_page_when_identifier_registered
    @identifier = 'test_event_identifier'
    RegistrationHandler.new({ 'identifier' => @identifier, 'rootUrl' => 'http://facebook.com' })
    path = "/sources/#{@identifier}/events"

    visit path

    assert_equal path, current_path
    assert_equal 'Events Statistics', find('h2').text
  end

  def test_user_sees_error_page_when_unregistered_identifier
    unregisterd_identifier = 'not_registered'

    visit "/sources/#{unregisterd_identifier}/events"

    assert_equal '/not_found', current_path
    assert_equal 'Error Page', find('h1').text
  end

  def test_user_sees_most_to_least_received_event
    skip
    @identifier = 'test_event_identifier'
    RegistrationHandler.new({ 'identifier' => @identifier, 'rootUrl' => 'http://facebook.com' })
    DataProcessingHandler.new(@raw_payload, @identifier)
    DataProcessingHandler.new(@raw_payload['payload'].sub('1920', '1111'), @identifier)
    DataProcessingHandler.new(@raw_payload['payload'].sub('socialLogin', 'otherEvent'), @identifier)
    path = "/sources/#{@identifier}/events"

    visit path

    assert_equal 2, Event.all.count
  end

end
