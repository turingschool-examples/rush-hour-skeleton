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

  def test_user_sees_shortest_response_time_for_url
    setup_testing_environment

    within('#shortest_response_time') do
      assert page.has_content?('Shortest Response Time')
      assert page.has_content?(37)
    end
  end

  def test_user_sees_avg_response_time_for_url
    setup_testing_environment

    within('#avg_response_time') do
      assert page.has_content?('Average Response Time')
      assert page.has_content?(38)
    end
  end

  def test_user_sees_http_verbs
    within('#verbs') do
      assert page.has_content?('HTTP Verbs Received')
      assert page.has_content?('GET')
    end
  end

  def test_user_sees_three_most_popular_refferers
    within('#referred_by') do
      assert page.has_content?('Most Popular Referrers')
      assert page.has_content?('www.google.com')
    end
  end
end
