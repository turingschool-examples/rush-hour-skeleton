require_relative '../test_helper'

class RequestTest < Minitest::Test
  def test_it_creates_application_with_valid_attributes
    Request.create(request_hash: Digest::SHA1.hexdigest("yeah"))
    expected = "e029e41f4e015e2ea604a0d81a05a05186f15b03"
    assert_equal expected, Request.last.request_hash
  end

  def test_request_belong_to_application
    Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")
    req = Request.create(application_id: 1,request_hash: Digest::SHA1.hexdigest("1"))
    assert_equal 'jumpstartlab', req.application.identifier
  end
end
