require './test/test_helper.rb'
require 'pry'

class ApplicationUrlStatsTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    super
    identifier = Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    @payload = '{
    "url":"http://jumpstartlab.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://jumpstartlab.com",
    "requestType":"GET",
    "parameters":[],
    "eventName": "socialLogin",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"
    }'
    # binding.pry
    post '/sources/jumpstartlab/data', "payload=#{@payload}"
  end

  def test_the_main_page_exists
    visit '/sources'
    assert_equal '/sources', current_path
    visit '/sources/jumpstartlab/urls'
    assert_equal '/sources/jumpstartlab/urls', current_path
    visit '/sources/jumpstartlab/urls'
    assert_equal '/sources/jumpstartlab/urls', current_path
    # visit '/sources/jumpstartlab/urls/jumpstartlab/blog'
    # assert_equal '/sources/jumpstartlab/urls/jumpstartlab/blog', current_path
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
