require_relative '../test_helper'

class CreateSourceTest < ControllerTest
  def test_can_create_source_with_identifier_and_root_url
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
  end

  def test_can_give_400_response_when_identifier_is_missing
    post '/sources' , { "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 400, last_response.status
    assert_equal "missing a parameter ya doofus", last_response.body
  end

  def test_can_give_400_response_when_root_url_is_missing
    post '/sources' , { "identifier" => "jumpstartlab" }
    assert_equal 400, last_response.status
    assert_equal "missing a parameter ya doofus", last_response.body
  end

  def test_can_give_a_403_status_when_identifier_already_exists
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 403, last_response.status
    assert_equal "identifier already exists", last_response.body
  end
end


