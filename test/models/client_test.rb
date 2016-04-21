require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_responds_to_payloads
    d = Client.create(identifier: "1", root_url: "turing.io")

    assert d.respond_to? :payloads
  end

  def test_brings_in_correct_data
    d = Client.create(identifier: "1", root_url: "turing.io")

    assert_equal "turing.io", d.root_url
  end

  def test_wont_validate_incorrect_data
    d = Client.create
    assert_nil d.id

    e = Client.new root_url: nil
    assert_nil e.root_url
  end

  def test_repeated_client_data_wont_create_nonunique_entries
    client1 = Client.create(identifier: "this", root_url: "turing.io")
    assert_equal 1, Client.count
    assert_equal 1, client1.id

    client2 = Client.create(identifier: "this", root_url: "turing.io")
    assert_equal 1, Client.count
    assert_nil client2.id
  end

  def test_find_or_initialize_by_wont_create_nonunique_entries
    client1 = Client.new(identifier: "this", root_url: "turing.io")
    assert_equal true, client1.save
    assert_equal 1, Client.count
    assert_equal 1, client1.id

    client2 = Client.new(identifier: "this", root_url: "turing.io")
    assert_equal false, client2.save
    assert_equal 1, Client.count
    assert_nil client2.id
  end
end
