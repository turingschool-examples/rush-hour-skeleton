require './test/test_helper'

class RegisterAppTest < ControllerTest
  def test_register_app_with_valid_attributes
  # As as guest,
  # When I POST to '/sources'
  # 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
  post '/sources', { applications: { identifier: "turing", rootUrl: "http://turing.io"} }
  # And I provide an identifier,
  # And I provide a rootUrl,
  # Then I receive a status of 200 OK,
  assert_equal 200, last_response.status
  assert_equal "{'identifier':'turing'}", last_response.body
  assert_equal 1, Application.count
  # And I receive a response of my identifier (as JSON)
  end
end
