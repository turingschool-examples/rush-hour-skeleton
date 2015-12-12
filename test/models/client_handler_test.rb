require_relative '../test_helper'

class ClientHandlerTest < Minitest::Test

  def test_client_handler_can_be_instantiated
    client = Client.new(name: "test", root_url: "test.com")
    c = ClientHandler.new(client)

    assert c
  end

  def test_client_handler_can_be_passed_a_new_client_and_generate_body
    client = Client.new(name: "test", root_url: "test.com")

    ch = ClientHandler.new(client)

    assert_equal "test", ch.client.name
    assert_equal "Client created.", ch.body
    assert_equal 200, ch.status
  end

  def test_client_handler_can_find_duplicate_client_and_return_403_http_status_and_correct_body
    client_1 = Client.new(name: "test", root_url: "test.com")
    ch = ClientHandler.new(client_1)

    assert_equal "Client created.", ch.body
    assert_equal 200, ch.status

    ch_2 = ClientHandler.new(client_1)

    assert_equal "Name already taken.", ch_2.body
    assert_equal 403, ch_2.status
  end

  def test_client_handler_can_return_400_http_status_for_missing_parameters
    client = Client.new({})
    ch = ClientHandler.new(client)

    assert_equal "Missing parameters.", ch.body
    assert_equal 400, ch.status
  end





end
