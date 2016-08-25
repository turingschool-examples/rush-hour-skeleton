require_relative '../test_helper'

class ReferredByTest < Minitest::Test
  include TestHelpers

  def test_it_validates_referred_by
    referred_by = ReferredBy.create(url: "www.google.com")

    assert ReferredBy.all.first.valid?
    assert_equal 1, ReferredBy.all.count
  end
end
