require './test/test_helper.rb'
require 'pry'

class ApplicationUrlStatsTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def default_setup
    identifier = Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    payload = {
    "url" => "http://jumpstartlab.com/blog",
    "requestedAt" => "2013-02-16 21:38:28 -0700",
    "respondedIn" => 37,
    "referredBy" => "http://jumpstartlab.com",
    "requestType" => "GET",
    "parameters" => [],
    "eventName" =>  "socialLogin",
    "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth" => "1920",
    "resolutionHeight" => "1280",
    "ip" => "63.29.38.211"
    }
    PayloadHelper.add_to_specific_tables(payload)
    payload = PayloadHelper.add_payload_data(payload)
    identifier.update(payload_id: payload.id)
  end

  def test_the_main_page_exists
    skip
    visit '/'
    assert_equal '/', current_path
    assert_equal 200, last_response.status
  end

  def test_the_page_exists_when_visited
    skip
    default_setup
    visit '/sources/jumpstartlab/urls/blog'
    assert_equal 200, last_response.status
  end

  def test_receive_an_error_when_the_page_does_not_exist
    skip
    identifier = Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    visit '/sources/jumpstartlab/urls/blog'
    message = "403 Forbidden - Application URL not registered"
    assert_equal 403, last_response.status
    assert_equal message, last_response.body
  end

  def test_when_i_visit_page_i_can_find_longest_response_time
    skip
  end
  #As a CLIENT
  #when I visit source_path(identifier) http://localhost:9393/sources/jumpstartlab/urls/specific_url
  #And the identifer exists for that client

  # When the url for the identifier does exists:
  #
  # Longest response time
  # Shortest response time
  # Average response time
  # Which HTTP verbs have been used
  # Most popular referrrers
  # Most popular user agents
  #
  #As a CLIENT - SAD PATH
  #when I visit source_path(identifier) http://localhost:9393/sources/jumpstartlab/urls/RELATIVE/PATH
  #And the identifer exists for that client
  #
  # I see a message that the url has not been requested

end
