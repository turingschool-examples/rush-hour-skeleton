require_relative '../test_helper'

class UrlTest < Minitest::Test

  def test_that_it_creates_a_url_row
    url = Url.new(path: "/blog" , root: "www.google.com" )
    assert url.valid?
  end

end
