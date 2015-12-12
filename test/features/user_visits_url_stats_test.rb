require_relative '../test_helper'

class UserVistitsURLStatsTest < FeatureTest
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

  def test_user_sees_longest_response_time_for_url
    create_testing_environment
    visit '/sources/jumpstartlab/urls/blog'

    within('#longest_response_time') do
      assert page.has_content?('Longest Response Time')
      assert page.has_content?(39)
    end
  end

  def test_user_sees_shortest_response_time_for_url
    create_testing_environment
    visit '/sources/jumpstartlab/urls/blog'

    within('#shortest_response_time') do
      assert page.has_content?('Shortest Response Time')
      assert page.has_content?(37)
    end
  end

  def test_user_sees_avg_response_time_for_url
    create_testing_environment
    visit '/sources/jumpstartlab/urls/blog'

    within('#avg_response_time') do
      assert page.has_content?('Average Response Time')
      assert page.has_content?(38)
    end
  end

  def test_user_sees_http_verbs
    create_testing_environment
    visit '/sources/jumpstartlab/urls/blog'

    within('#verbs') do
      assert page.has_content?('HTTP Verbs Received')
      assert page.has_content?('GET')
    end
  end

  def test_user_sees_three_most_popular_referers
    create_more_payloads
    visit '/sources/jumpstartlab/urls/blog'

    within('#referred_by') do
      assert page.has_content?('Top 3 Bestest Referrers')
      refute page.has_content?('google.com')
      assert page.has_content?('jumpstartlab.com')
    end
  end

  def test_user_sees_three_most_popular_browsers
    create_more_payloads
    visit '/sources/jumpstartlab/urls/blog'
    within('#browsers') do
      assert page.has_content?('Top 3 Bestest BadAss Browsers')
      assert page.has_content?('Chrome')
    end
  end
end
