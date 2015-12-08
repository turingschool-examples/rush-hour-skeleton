require_relative '../test_helper'

class RegisterNewUserTest < TrafficTest

  def test_create_genre_with_valid_attributes
      post '/sources', { identifier=jumpstartlab&rootUrl=http://jumpstartlab.com }               # post method comes from Rack::Test::Methods. second argument is data params

      assert_equal 200, last_response.status
      
    end


end
