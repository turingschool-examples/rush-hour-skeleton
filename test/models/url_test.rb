require_relative '../test_helper'

class UrlTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_partial_information_is_entered
    url = Url.new({ })
    refute url.save
  end

  def test_it_returns_true_when_all_information_is_entered
    url = Url.new({ address: "www's!"})
    assert url.save
  end


  def test_it_generates_list_of_urls_by_frequency
    url1 = Url.create({address: "http://www.google.com"})
    url2 = Url.create({address: "http://www.google.com"})
    url3 = Url.create({address: "http://www.nyt.com"})
    url4 = Url.create({address: "http://www.nyt.com"})
    url5 = Url.create({address: "http://www.nyt.com"})
    assert_equal ["http://www.nyt.com", "http://www.google.com"], Url.list_urls_by_frequency
  end
end
