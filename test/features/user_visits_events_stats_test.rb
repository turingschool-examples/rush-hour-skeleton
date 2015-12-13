require_relative '../test_helper'

class UserVistitsEventsStatsTest < FeatureTest
  include PayloadPrep

  def create_testing_environment
    post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}

    post '/sources/jumpstartlab/data', payload_params1
    post '/sources/jumpstartlab/data', payload_params2
    post '/sources/jumpstartlab/data', payload_params3
  end

  def create_more_payloads
    post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}

    post '/sources/jumpstartlab/data', payload_params1
    post '/sources/jumpstartlab/data', payload_params2
    post '/sources/jumpstartlab/data', payload_params3
    post '/sources/jumpstartlab/data', payload_params4
    post '/sources/jumpstartlab/data', payload_params5
  end

  def test_user_sees_hourly_breakdown_of_events
    create_more_payloads
    visit '/sources/jumpstartlab/events/socialLogin'

    within('#event_data') do
      assert page.has_content?('Event type:')
      assert page.has_content?('19:00')
    end
  end

  def test_user_sees_total_number_of_events
    create_more_payloads
    visit '/sources/jumpstartlab/events/socialLogin'

    within('#event_data') do
      assert page.has_content?('Total')
      assert page.has_content?('3')
    end
  end

  def test_user_sees_undefined_event_message_page
    create_more_payloads
    visit '/sources/jumpstartlab/events/pizzamarshmallows'
    assert page.has_content?('No data received for /pizzamarshmallows')
  end

  def test_user_sees_undefined_event_message_page
    create_more_payloads
    visit '/sources/jumpstartlab/events/pizzamarshmallows'
    click_link("return_to_index")
    assert page.has_content?('Events Index')
  end

end
