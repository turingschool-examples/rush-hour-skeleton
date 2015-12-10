require_relative '../test_helper'

class UserVistitsURLStatsTest < FeatureTest
  include PayloadPrep

  def setup_testing_environment
    post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}

    post '/sources/jumpstartlab/data', payload_params1
    post '/sources/jumpstartlab/data', payload_params2
    post '/sources/jumpstartlab/data', payload_params3

    visit '/sources/jumpstartlab/urls/blog'
  end

  def test_user_sees_longest_response_time_for_url
    setup_testing_environment

    within('#longest_response_time') do
      assert page.has_content?('Longest Response Time')
      assert page.has_content?(39)
    end
  end

end
