require_relative "../test_helper"

class ApplicationRegistrationTest < FeatureTest

  def test_it_creates_a_source
    visit "/sources"
      response = `curl -i -d 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'  http://localhost:9393/sources`
    # within(.status) do
      assert_equal 1, response
    # end
  end

end

# APPLICATION REGISTRATION
# As a user
# When I submit a POST request to "/sources"
# With an "identifier" set to "jumpstartlab"
# And a "rootUrl" set to "http://jumpstartlab.com"
# Then I should receive a response of 200 OK
# And a response body of "{"identifier": "jumpstartlab"}"
#
# When I submit a POST request to "/sources"
# And I am missing an "identifier" and "rootUrl"
# Then I should receive response of 400 Bad Request
#
# When I submit a POST request to "/sources"
# With an "identifier" of "jumpstartlab"
# And the "identifier" has already been taken
# Then I should receive response of 403 Forbidden
# And I should receive a descriptive error message "That identifier has already been taken."