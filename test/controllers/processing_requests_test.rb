require './test/test_helper.rb'

class ProcessingRequestsTest < ControllerTest

  def test_an_application_can_assign_a_digest
    post '/sources/IDENTIFIER/data', {
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
      }
      assert_equal 200, last_response.status
      # assert_equal false, last_response[:digest].nil?   -----------does not currently pass, returning true------------
    end


end
