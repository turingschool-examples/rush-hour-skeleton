require_relative '../test_helper'
require './app/models/url'

class UrlTest < ModelTest
  def test_it_validates_input
    url = Url.new({url: "http://www.something.com"})

    url_sad = Url.new({})
    assert url.save
    refute url_sad.save
  end

  def test_it_has_unique_urls
    url = Url.create({url: "http://www.something.com"})
    url = Url.new({url: "http://www.something.com"})

    refute url.save
  end
end
