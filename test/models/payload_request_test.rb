require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test

  def test_payload_without_info_is_not_valid
    refute PayloadRequest.create(url: "http://jumpstartlab.com/blog").valid?
  end

end
