require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_validates_url
    url = Url.create(url: "www.google.com")
    assert url.valid?
  end
end
