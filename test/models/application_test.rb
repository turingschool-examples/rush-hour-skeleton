require_relative '../test_helper'

class ApplicationTest < Minitest::Test

  def application_data
    {
      identifier: 'jumpstartlab',
      root_url:   'http://jumpstartlab.com'
    }
  end

  def test_application_is_created_with_valid_attributes
    Application.create(application_data)
    assert_equal "jumpstartlab", Application.last.identifier
    assert_equal "http://jumpstartlab.com", Application.last.root_url
  end

  def test_application_has_many_requests
    app = Application.create(application_data)
    Request.create(application_id: 1,request_hash: Digest::SHA1.hexdigest("1"))
    Request.create(application_id: 1,request_hash: Digest::SHA1.hexdigest("2"))

    assert_equal 2, app.requests.count
  end
end
