require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url_instance
    skip
    url = create_url
    address = "http://jumpstartlab.com/blog"

    assert_equal address, url.address
    refute_nil? url.referred_by_id
    refute referred_bys.empty?
  end

end
