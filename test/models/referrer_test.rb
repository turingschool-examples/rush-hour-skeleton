require_relative '../test_helper'

class ReferrerTest < Minitest::Test

  def test_it_can_create_referrer
    website = Referrer.create(address:"google.com")
    assert_equal "google.com", website.address
  end

end
