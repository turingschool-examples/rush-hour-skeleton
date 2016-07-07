require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url_instance
    url = create_url
    address = "http://jumpstartlab.com/blog"

    assert_equal address, url.address
    refute_nil url.referral_id
  end

end
