require_relative '../test_helper.rb'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_can_hold_a_root_url_and_path
    url = Url.create(root_url: "http://www.google.com", path: "/")
    assert_equal '/', url.path
    assert_equal 'http://www.google.com', url.root_url
    assert url.valid?
  end

  def test_it_returns_all_paths
    Url.create(root_url: "http://www.google.com", path: "/maps")
    Url.create(root_url: "http://www.google.com", path: "/translate")
    Url.create(root_url: "http://www.google.com", path: "/maps")

    assert_equal 3, Url.all.count
    assert_equal ["/maps", "/translate"], Url.all_paths
  end

  def test_it_returns_all_root_urls
    Url.create(root_url: "http://www.facebook.com", path: "/photos")
    Url.create(root_url: "http://www.google.com", path: "/translate")
    Url.create(root_url: "http://www.facebook.com", path: "/about")

    assert_equal 3, Url.all.count
    assert_equal ["http://www.facebook.com", "http://www.google.com"], Url.all_roots
  end

  def test_it_returns_a_descending_list_of_most_requested
    Url.create(root_url: "http://www.facebook.com", path: "/photos")
    Url.create(root_url: "http://www.google.com", path: "/translate")
    Url.create(root_url: "http://www.facebook.com", path: "/about")
    Url.create(root_url: "http://www.google.com", path: "/translate")
    Url.create(root_url: "http://www.facebook.com", path: "/about")
    Url.create(root_url: "http://www.facebook.com", path: "/about")

    assert_equal 6, Url.all.count
    assert_equal ["http://www.facebook.com/about", "http://www.google.com/translate", "http://www.facebook.com/photos"], Url.most_to_least

  end
end
