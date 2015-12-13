require_relative '../test_helper'

class ServerPayloadTest < TrafficTest
  include PayloadPrep

  def test_returns_full_linked_path
    # register_user_thru_controller
    # post '/sources/jumpstartlab/data', payload_params1
    payload_full_path = "http://jumpstartlab.com/blog"
    extension = "urls"
    expected = "/sources/jumpstartlab/urls/blog"

    actual = linked_path(payload_full_path, extension)
    assert_equal expected, actual
  end

end
