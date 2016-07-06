require_relative '../test_helper.rb'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_hold_a_root_url_and_path
    url = Url.create(root_url: "http://www.google.com", path: "/")
    assert_equal '/', url.path
    assert_equal 'http://www.google.com', url.root_url
  end
end
