require_relative "../test_helper"

class ClientTest < Minitest::Test
    include TestHelpers

  def setup
    @client1 = Client.create({:root_url => "www.google.com",
                              :identifier => "www.jumpstart.labs"
                              })
    @client2 = Client.create({:root_url => "www.google.com"
                              })
  end

  def test_it_validates_new_client_with_all_fields
    assert @client1.valid?
  end

  def test_it_does_not_validate_new_client_with_missing_fields
    refute @client2.valid?
  end


end
