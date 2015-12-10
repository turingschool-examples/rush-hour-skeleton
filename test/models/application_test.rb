require_relative '../test_helper'

class ApplicationTest < Minitest::Test
  def test_it_creates_application_with_valid_attributes
    Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")
    assert_equal "jumpstartlab", Application.last.identifier
    assert_equal "http://jumpstartlab.com", Application.last.root_url
  end

  def test_application_has_many_requests
    app = Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")
    Request.create(application_id: 1,request_hash: Digest::SHA1.hexdigest("1"))
    Request.create(application_id: 1,request_hash: Digest::SHA1.hexdigest("2"))
    # binding.pry
    assert_equal 2, app.requests.count
  end
end
