require_relative '../test_helper'

class ServerTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_create_new_client_with_valid_attributes
    post '/sources', 'identifier=chickie&rootUrl=www.chickpea.com'

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"chickie\"}", last_response.body
  end

  def test_create_new_client_with_no_attributes
    post '/sources', ""

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank, Identifier can't be blank", last_response.body
  end

  def test_cant_create_duplicate_client
    create_clients(1)

    post '/sources', 'identifier=thing0&rootUrl=www.another_thing.com0'

    assert_equal 1, Client.count
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
  end



end
