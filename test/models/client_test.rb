require_relative '../test_helper'
require_relative '../../app/models/client'

class ClientTest < Minitest::Test

  def test_can_create_client
    c = Client.new("JumpstartLabs")

    assert c
    assert_equal "JumpstartLabs", c.name
  end

end
