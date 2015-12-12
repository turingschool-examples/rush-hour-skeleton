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
      save_and_open_page
      assert page.has_content?('Event Popularity Contest')
      assert page.has_content?('registrationInformation')
    end
  end


end
