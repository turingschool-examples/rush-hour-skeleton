require './test/test_helper'

class SendPayloadTest < Minitest::Test
  include TestHelper
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def test_parses_payload_

  end
end
