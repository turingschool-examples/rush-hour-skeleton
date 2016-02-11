require_relative '../test_helper'

class PayloadTest < Minitest::Test
  include TestHelpers


  def test_returns_max_response_time_for_given_url
    client_url = "http://jumpstartlab.com"
    setup_1
    analyst = ClientUrlAnalyst.new(Payload)
    binding.pry
    time = analyst.max_url_response_time(client_url)
    assert_equal 10, time
  end



end
