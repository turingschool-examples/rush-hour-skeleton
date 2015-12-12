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
      assert page.has_content?('Times Requested:')
      assert page.has_content?(21)
    end
  end

end
