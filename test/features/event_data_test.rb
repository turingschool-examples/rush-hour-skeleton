require_relative '../test_helper'

class EventDataTest < FeatureTest

  def setup
    super

    @identifier = 'test_event_identifier'
    @event_name = 'test_event'
    register(@identifier)
    @path = "/sources/#{@identifier}/events/#{@event_name}"
  end

  def test_user_sees_error_page_when_unregistered_identifier
    unregisterd_identifier = 'not_registered'

    visit "/sources/#{unregisterd_identifier}/events/#{@event_name}"

    assert_equal '/not_found', current_path
    assert_equal 'Error', find('h1').text
  end

  def test_user_sees_error_message_when_no_event
    event_does_not_exist = 'does_not_exist'
    message = "No event named #{event_does_not_exist} exists"
    link = "Events"
    path = "/sources/#{@identifier}/events/#{event_does_not_exist}"

    visit path

    assert_equal path, current_path
    assert_equal message, find('h4').text
    assert_equal true, find_link(link).visible?
  end

  def test_user_sees_how_many_times_event_recieved
    create_events(@event_name, 5)

    visit @path

    assert_equal @event_name, all('tbody tr td').first.text
    assert_equal '5', all('tbody tr td').last.text
  end

  def test_user_sees_event_by_hour
    create_events_on_hour(@event_name, 5, 1)
    create_events_on_hour(@event_name, 3, 4)
    create_events_on_hour(@event_name, 2, 20)

    visit @path

    assert_equal '1 am', all('tbody').last.all('tr td').first.text
    assert_equal '8 pm', all('tbody').last.all('tr').last.all('td').first.text
    assert_equal '2', all('tbody').last.all('tr').last.all('td').last.text
  end


  private

  def register(identifier)
    RegistrationHandler.new({ 'identifier' => identifier, 'rootUrl' => 'http://facebook.com' })
  end

  def create_events(name, how_many)
    (1..how_many).each do
      event_payload = return_event_with_name(name)
      create_event(event_payload)
    end
  end

  def create_events_on_hour(name, how_many, hour)
    (1..how_many).each do
      event_payload = return_event_on_hour(hour, name)
      create_event(event_payload)
    end
  end

  def create_event(event_payload)
    DataProcessingHandler.new(return_unique_payload(event_payload), @identifier)
  end

  def return_event_with_name(name)
    payload            = {}
    payload['payload'] = @raw_payload['payload'].sub('socialLogin', name)
    payload
  end

  def return_event_on_hour(hour, name)
    return nil if hour < 0 || hour > 24
    payload            = return_event_with_name(name)
    payload['payload'] = payload['payload'].sub('2013-02-16 21:38:28 -0700', "2013-02-16 #{hour}:00:00")
    payload
  end

  def return_unique_payload(original_payload)
    # Couldn't figure out how to make a static counter for the test class so just used random for now
    original_payload['payload'] = original_payload['payload'].sub('1920', Random.new().rand(9999).to_s)
    original_payload
  end

end
