require_relative '../test_helper'

class UrlTest < Minitest::Test

  def test_it_can_create_url
    url = Url.create(address: "Turing.io")
    assert_equal "Turing.io", url.address
  end
end
