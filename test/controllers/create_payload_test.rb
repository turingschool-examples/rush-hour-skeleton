require './test/test_helper'

class CreatePayloadTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_response, etc.

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy::Server
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_creates_payload
    skip
    user = User.create({ 'identifier' => 'jumpstartlab',
                      'rootUrl'    => 'http://jumpstartlab.com'})
    # binding.pry

    post '/sources/jumpstartlab/data',
      { "payload" =>
    		{
          'url'              => "http://jumpstartlab.com/blog",
    		  'requestedAt'      => "2013-02-16 21:38:28 -0700",
          'respondedIn'      => 37,
    		  'referredBy'       => "http://jumpstartlab.com",
    		  'requestType'      => "GET",
    		  'parameters'       => [],
          'eventName'        => "socialLogin",
    		  'userAgent'        => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    		  'resolutionWidth'  => "1920",
    		  'resolutionHeight' => "1280",
    		  'ip'               => "63.29.38.211"
        }
      }

  	assert_equal 1, Payload.count
    assert_equal 200, last_response.status
    assert_equal 'success', last_response.body
  end
 end
