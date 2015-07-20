require_relative '../test_helper'

class EventsDataTest < FeatureTest

  def setup
    super

    @identifier = 'test_event_identifier'
    register(@identifier)
    @path = "/sources/#{@identifier}/events"
  end


  def test_user_sees_index_page_when_identifier_registered
    visit @path

    assert_equal @path, current_path
  end

  def test_user_sees_error_page_when_unregistered_identifier
    unregisterd_identifier = 'not_registered'

    visit "/sources/#{unregisterd_identifier}/events"

    assert_equal '/not_found', current_path
    assert_equal 'Error', find('h1').text
  end

  def test_user_sees_most_to_least_received_event
    create_events('goldMedal', 5)
    create_events('silverMedal', 3)
    create_events('bronzeMedal', 1)

    visit @path

    assert_equal 3, all('tbody tr').count
    assert_equal 'goldMedal', all('tbody tr td').first.text
    assert_equal '1', all('tbody tr').last.all('td').last.text
  end

  def test_user_goes_to_event_details_page_when_clicks_on_event_name
    event_name = 'link_to_event_details'
    create_events(event_name, 10)
    expected_path = "/sources/#{@identifier}/events/#{event_name}"

    visit @path
    assert_equal true, find_link(event_name).visible?

    click_link(event_name)
    assert_equal expected_path, current_path
  end

  def test_user_sees_message_when_no_events_to_display
    message = "No Events to Display"
    visit @path

    assert page.has_content?("No Events to Display")
  end

  private

  def register(identifier)
    RegistrationHandler.new({ 'identifier' => identifier, 'rootUrl' => 'http://facebook.com' })
  end

  def create_events(name, how_many)
    (1..how_many).each do
      event_payload = return_event_with_name(name)
      DataProcessingHandler.new(return_unique_payload(event_payload), @identifier)
    end
  end

  def return_event_with_name(name)
    payload            = {}
    payload['payload'] = @raw_payload['payload'].sub('socialLogin', name)
    payload
  end

  def return_unique_payload(original_payload)
    # Couldn't figure out how to make a static counter for the test class so just used random for now
    original_payload['payload'] = original_payload['payload'].sub('1920', Random.new().rand(9999).to_s)
    original_payload
  end

end
