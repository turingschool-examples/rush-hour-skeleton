require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_validates_url
    url = Url.create(url: "www.google.com")

    assert Url.all.first.valid?
    assert_equal 1, Url.all.count
  end
end
