require_relative '../test_helper'

class UserVistitsEventsIndex < FeatureTest
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

  def test_user_can_view_events_list
    create_more_payloads
    visit '/sources/jumpstartlab/events'
    within('#event_frequency') do
      assert page.has_content?('Event Popularity Contest')
      assert page.has_content?('registrationInformation')
    end
  end

  def test_user_can_click_link_for_specific_event
    create_more_payloads
    visit '/sources/jumpstartlab/events'
    within('#event_frequency') do
      assert page.has_content?('Event Popularity Contest')
    end
    click_link('event_data_socialLogin')
    refute page.has_content?('Event Popularity Contest')
  end

  def test_user_sees_error_page_for_no_defined_events
    post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}
    visit '/sources/jumpstartlab/events'
    assert page.has_content?('No events received for Jumpstartlab')
  end

end
