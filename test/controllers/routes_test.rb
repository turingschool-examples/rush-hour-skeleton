require_relative '../test_helper'

class RoutesTest < TrafficTest
  include PayloadPrep

  def create_testing_environment
    post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}
    post '/sources/jumpstartlab/data', payload_params1
    post '/sources/jumpstartlab/data', payload_params2
  end

  def test_root_path
    get '/'
    assert_equal 200, last_response.status
  end

  def test_sources_id_path
    create_testing_environment
    get '/sources/jumpstartlab'
    assert_equal 200, last_response.status
  end

  def test_sources_id_urls_realtive_path
    create_testing_environment
    get '/sources/jumpstartlab/urls/blog'
    assert_equal 200, last_response.status
  end

  def test_sources_id_events
    create_testing_environment
    get '/sources/jumpstartlab/events'
    assert_equal 200, last_response.status
  end

  def test_sources_id_events_event_name
    create_testing_environment
    get '/sources/jumpstartlab/events/socialLogin'
    assert_equal 200, last_response.status
  end

  def test_post_sources
    post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}
    assert_equal 200, last_response.status
  end

  def test_post_sources_id_data
    create_testing_environment
    post '/sources/jumpstartlab/data', payload_params3
    assert_equal 200, last_response.status
  end

end
