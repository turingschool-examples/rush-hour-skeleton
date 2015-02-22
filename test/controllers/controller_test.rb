require './test/test_helper.rb'

class CreateIdentifierTest < Minitest::Test
  include Rack::Test::Methods

  def app
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
    # binding.pry
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

  def test_it_loads_data_into_respective_tables
    default_payload_setup
    post '/sources/jumpstartlab/data', "payload=#{@payload}"
    assert Agent.exists?(browser: "Chrome", version: "24.0.1309.0", platform: "Macintosh")
    assert Dimension.exists?(height: "1280", width: "1920")
    assert Event.exists?(name: "socialLogin")
    assert Ip.exists?(address: "63.29.38.211")
    assert Referral.exists?(url: "http://jumpstartlab.com")
    assert Request.exists?(request_type: "GET")
    assert Url.exists?(address: "http://jumpstartlab.com/blog")
  end

  def test_it_loads_data_into_respective_tables
    default_payload_setup
    post '/sources/jumpstartlab/data', "payload=#{@payload}"
    dim_id = Dimension.where(height: "1280", width: "1920").to_a[0].id
    assert_equal dim_id, Payload.where(dimension_id: dim_id).to_a[0].dimension_id
  end

  def test_it_forbids_no_application_url
    post '/sources/jumpstartlab/data', "payload={}"
    message = "403 Forbidden - Application URL not registered"
    assert_equal 403, last_response.status
    assert_equal message, last_response.body
  end

  def test_identifies_duplicate_payload
    default_payload_setup
    post '/sources/jumpstartlab/data', "payload=#{@payload}"
    post '/sources/jumpstartlab/data', "payload=#{@payload}"
    message = "403 Forbidden - Payload Exists"
    assert_equal 403, last_response.status
    assert_equal message, last_response.body
  end

  def test_it_assigns_the_identifier_id_to_the_payload
    default_payload_setup
    Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    post '/sources/jumpstartlab/data', "payload=#{@payload}"
    payload_id = Payload.where(requested_at: "2013-02-16 21:38:28 -0700").to_a[0].id
    identifier_id = Identifier.where(name: 'jumpstartlab').to_a[0].id
    assert_equal identifier_id, Payload.find(payload_id).identifier_id
  end
end
