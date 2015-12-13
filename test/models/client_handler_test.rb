require_relative '../test_helper'

class ClientHandlerTest < Minitest::Test

  def test_client_handler_can_be_instantiated
    client = Client.new(name: "test", root_url: "test.com")
    c = ClientHandler.new(client)

    assert c
  end

  def test_client_handler_returns_200_status_with_valid_client
    client = Client.new(name: "test", root_url: "test.com")

    ch = ClientHandler.new(client)

    assert_equal "test", ch.client.name
    assert_equal "Client created.", ch.body
    assert_equal 200, ch.status
  end

  def test_client_handler_returns_403_status_and_name_take_body_with_duplicate_client
    client = Client.new(name: "test", root_url: "test.com")
    ch = ClientHandler.new(client)

    assert_equal "Client created.", ch.body
    assert_equal 200, ch.status

    ch_2 = ClientHandler.new(client)

    assert_equal "Name already taken.", ch_2.body
    assert_equal 403, ch_2.status
  end

  def test_client_handler_returns_400_status_and_missing_params_body_with_missing_parameters
    client = Client.new({})
    ch = ClientHandler.new(client)

    assert_equal "Missing parameters.", ch.body
    assert_equal 400, ch.status
  end

end
