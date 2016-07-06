require_relative '../test_helper.rb'

class ReferredByTest < Minitest::Test
  include TestHelpers

  def test_it_can_hold_a_root_url_and_path
    referred_by = ReferredBy.create(root_url: "http://www.google.com", path: "/")
    assert_equal '/', referred_by.path
    assert_equal 'http://www.google.com', referred_by.root_url
    assert referred_by.valid?
  end
end
