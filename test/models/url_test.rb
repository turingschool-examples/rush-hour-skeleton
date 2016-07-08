require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_url
    url = Url.create(address:"Turing.io")
    assert_equal "Turing.io", url.address
  end

  def test_urls_from_most_requested_to_least_requested
    url = Url.create(address:"http://www.turing.io")
    url = Url.create(address:"http://www.turing.io")
    url = Url.create(address:"http://www.foragoodstrftime.com/")
    url = Url.create(address:"http://www.foragoodstrftime.com/")
    url = Url.create(address:"http://www.turing.io")
    url = Url.create(address:"http://www.galvanize.com")

    expected = "http://www.turing.io"
    assert_equal expected, Url.urls_from_most_to_least_requested
  end
end
