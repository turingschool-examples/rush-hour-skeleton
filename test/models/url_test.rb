require_relative '../test_helper'
require './app/models/url'

class UrlTest < Minitest::Test
  def test_it_validates_input
    url = Url.new({url: "http://www.something.com"})

    url_sad = Url.new({})
    assert url.save
    refute url_sad.save
  end
end