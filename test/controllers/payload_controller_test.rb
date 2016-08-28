require_relative '../test_helper'
require './app/controllers/server'

class PayloadControllerTest < ControllerTest
  def test_it_can_register_an_application
    post '/sources', {'identifier'=>'jumpstartlab', 'rootUrl'=>'http://jumpstartlab.com'}
    post '/sources/jumpstartlab/data', {payload: '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'}

    assert_equal 200, last_response.status
    assert_equal "200 OK", last_response.body
    assert_equal 1, PayloadRequest.count
  end

  def test_it_does_not_register_an_invalid_application
    post '/sources', {'identifier'=>'jumpstartlab', 'rootUrl'=>'http://jumpstartlab.com'}
    post '/sources/jumpstartlab/data'

    assert_equal 400, last_response.status
    assert_equal "400 Bad Request: Requested at can't be blank. Responded in can't be blank. Resolution can't be blank. System information can't be blank. Referral can't be blank. Ip can't be blank. Request type can't be blank. Url can't be blank", last_response.body
    assert_equal 0, PayloadRequest.count
  end

  def test_it_does_not_register_a_duplicate_application
    post '/sources', {'identifier'=>'jumpstartlab', 'rootUrl'=>'http://jumpstartlab.com'}
    post '/sources/jumpstartlab/data', {payload: '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'}

    post '/sources/jumpstartlab/data', {payload: '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'}

    assert_equal 403, last_response.status
    assert_equal "403 Forbidden - Already Received Request", last_response.body
    assert_equal 1, PayloadRequest.count
  end

  def test_it_does_not_register_a_URL_that_does_not_exist

    post '/sources/jumpstartlab/data', {payload: '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'}

    assert_equal 403, last_response.status
    assert_equal "403 Forbidden - Application Not Registered", last_response.body
    assert_equal 0, PayloadRequest.count
  end
end
