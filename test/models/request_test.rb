require_relative '../test_helper'

class RequestTest < Minitest::Test
  def test_it_creates_application_with_valid_attributes
    Request.create(request_hash: Digest::SHA1.hexdigest("yeah"))
    expected = "e029e41f4e015e2ea604a0d81a05a05186f15b03"
    assert_equal expected, Request.last.request_hash
  end
end
