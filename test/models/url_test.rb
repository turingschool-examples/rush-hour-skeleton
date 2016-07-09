require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_that_it_creates_a_url_row
    url = Url.new(root: "www.google.com", path: "/blog")
    assert url.valid?
  end

  def test_it_does_not_get_created_without_browser_info
    url = Url.new(root: nil, path: "/blog")
    refute url.valid?
  end

  def test_it_does_not_get_created_without_browser_info
    url = Url.new(root: "www.google.com", path: nil)
    refute url.valid?
  end

  def test_it_has_a_relationship_with_payload_requests
    url = Url.new
    assert url.respond_to?(:payload_requests)
  end

  def test_it_has_unique_path_for_each_url_root
    url = Url.create(root: "www.google.com", path: "/blog")
    url2 = Url.create(root: "www.google.com", path: "/blog")
    url3 = Url.create(root: "www.google.com", path: "/news")

    assert url.valid?
    refute url2.valid?
    assert url3.valid?
    assert_equal 2, Url.count
  end

end
