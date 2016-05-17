require_relative "../test_helper"

class UrlTest < Minitest::Test

  def test_it_has_relationship_with_payload_request
    url = Url.new
    assert_respond_to(url, :payload_requests)
  end
end
