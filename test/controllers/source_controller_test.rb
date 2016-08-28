require_relative '../test_helper'
require './app/controllers/server'

class SourceControllerTest < ControllerTest
  def test_it_can_handle_incomplete_request
    post '/sources'

    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank, Identifier can't be blank", last_response.body
    assert_equal 0, Client.count

  end

  def test_it_can_create_a_client
    post '/sources', {'identifier'=>'jumpstartlab', 'rootUrl'=>'http://jumpstartlab.com'}

    assert_equal 200, last_response.status
    assert_equal "{\"identifier\": \"jumpstartlab\"}", last_response.body
    assert_equal 1, Client.count
  end

  def test_wont_allow_duplicates
    post '/sources', {'identifier'=> 'jumpstartlab', 'rootUrl'=>'http://jumpstartlab.com' }
    post '/sources', {'identifier'=> 'jumpstartlab', 'rootUrl'=>'http://jumpstartlab.com' }

    assert_equal 403, last_response.status
  end

  def test_it_can_retrieve_client_data
    post '/sources', {'identifier'=>'jumpstartlab', 'rootUrl'=>'http://jumpstartlab.com'}
    post '/sources/jumpstartlab/data', {payload: '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'}
    get '/sources/jumpstartlab'

    assert_equal 200, last_response.status
  end

  def test_it_will_have_an_appropriate_response_if_there_is_no_identifier
    get '/sources/jumpstartlab'
    assert_equal 403, last_response.status
  end

  def test_it_will_have_an_appropriate_response_if_there_is_no_payloads
    post '/sources', {'identifier'=>'jumpstartlab', 'rootUrl'=>'http://jumpstartlab.com'}
    get '/sources/jumpstartlab'
    assert_equal 403, last_response.status
  end
end
