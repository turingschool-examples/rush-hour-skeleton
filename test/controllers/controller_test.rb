require './test/test_helper.rb'

class CreateIdentifierTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_request, etc.

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy::Server
  end

  def default_payload_setup
    Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
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
  end

  def test_it_creates_an_identifier_with_correct_parameters
    post '/sources', {identifier: 'jumpstartlab',
                      rootUrl: 'jumpstartlab.com' }
    assert_equal 200, last_response.status
    assert_equal 1, Identifier.count
    assert_equal '{"identifier":"jumpstartlab"}', last_response.body
  end

  def test_it_does_not_accept_without_validation
    message = "400 Bad Request\nName can't be blank Root url can't be blank"
    post '/sources', {}
    assert_equal 400, last_response.status
    assert_equal 0, Identifier.count
    assert_equal message, last_response.body
  end

  def test_it_does_not_allow_duplicate_identifier
    message = "403 Forbidden\nName has already been taken"
    attributes = {identifier: 'jumpstartlab',
                  rootUrl: 'jumpstartlab.com' }
    Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    post '/sources', attributes
    assert_equal 403, last_response.status
    assert_equal message, last_response.body
  end

  def test_it_gives_error_if_missing_identifier
    post '/sources/jumpstartlab/data'
    assert_equal 400, last_response.status
  end

  def test_identifies_succesful_payload
    default_payload_setup
    post '/sources/jumpstartlab/data', {payload: @payload}
    assert_equal 200, last_response.status
  end

  def test_identifies_missing_payload
    Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    post '/sources/jumpstartlab/data'
    message = "Missing Payload - 400 Bad Request"
    assert_equal 400, last_response.status
    assert_equal message, last_response.body
  end

  def test_it_turns_hash_string_to_hash
    default_payload_setup
    assert JSON.parse(@payload).is_a?(Hash)
  end

  def test_url_is_entered_into_database
    Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog"}'
    assert Url.exists?(address: "http://jumpstartlab.com/blog")
  end

  def test_ip_and_payload_info_is_entered_into_db
    default_payload_setup
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog"}'
    assert Url.exists?(address: "http://jumpstartlab.com/blog")
    assert Url.exists?(address: "http://jumpstartlab.com/blog")
  end

  def test_identifies_duplicate_payload
    skip
    default_payload_setup
    post '/sources/jumpstartlab/data', {payload: @payload}
    post '/sources/jumpstartlab/data', {payload: @payload}
    message = "403 Forbidden - Payload Exists"
    assert_equal 403, last_response.status
    assert_equal message, last_response.body
  end

  #def setup
  #As a CLIENT
     #indentifier = Identifier.create()
    #visit source_path(identifier) ttp://yourapplication:port/sources/IDENTIFIER
  #And an identifer exists for that client
  #end

  #def test_it_displays_the_most_visited_urls
  #end
  #I should see  a page that displays the most requested URLS to least requested URLS (url)
  #And I should see a web browser breakdown across all requests (userAgent)
  #And I should see a OS breakdown across all requests (userAgent)
  #And I should see a Screen Resolution across all requests (resolutionWidth x resolutionHeight)
  #And I should see a Longest, average response time per URL to shortest, average response time per URL
  #And I should see a Hyperlinks of each url to view url specific data
  #And I should see a Hyperlink to view aggregate event data


  #As a CLIENT
  #When I visit http://yourapplication:port/sources/IDENTIFIER
  #And an identifer does not exist for that client
  #Then I should see the following message ""
end
