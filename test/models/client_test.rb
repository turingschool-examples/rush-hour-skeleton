require_relative '../test_helper'

class ClientTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_empty
    client = Client.new({ })
    refute client.save
  end

  def test_it_also_returns_false_when_partial_info_entered_with_identifier
    client = Client.new({ identifier: "jumpStartLabs"} )
    refute client.save
  end

  def test_it_returns_false_when_partial_info_entered_with_root_url
    client = Client.new({ root_url: "turing.io"} )
    refute client.save
  end

  def test_it_returns_true_when_all_information_is_entered
    client = Client.new({ identifier: "jumpStartLabs", root_url: "turing.io" })
    assert client.save
  end
end
