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
end
