require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_has_an_identifier_attribute
    client = Client.new

    assert_respond_to client, :identifier
  end

  def test_it_has_a_root_url_attribute
    client = Client.new

    assert_respond_to client, :root_url
  end

  def test_attribute_must_be_present_when_saving
    client = Client.new

    refute client.save
    refute_equal 1, Client.all.size
  end
end
