require './test/test_helper'

class RegisterTest < ControllerTest
  def test_registers_a_client_with_valid_request
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    assert_equal 200, last_response.status
    assert_equal "{'identifier':'jumpstartlab'}", last_response.body
    
  end

  def test_
    
  end

end


# As a user
# when i send a post request to
# http://localhost:9595/sources with the parameters:
#       curl -i -d 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'  http://localhost:4567/sources
# return status 200 OK with the data as JSON:
#             {"identifier":"jumpstartlab"}
#
# As a user
# when i send a post request to
# http://localhost:9595/sources with the parameters:
#       curl -i -d 'rootUrl=http://jumpstartlab.com'  http://localhost:4567/sources
# return status 400  with "Please provide identifier"
