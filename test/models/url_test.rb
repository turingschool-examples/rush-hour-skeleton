require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_url
    Url.create(root_url: "www.jumpstartlabs.com",
                   path: "/example")

    url = Url.first

    assert_equal "www.jumpstartlabs.com", url.root_url
    assert_equal "/example", url.path
  end

  def test_it_doesnt_save_url_with_invalid_path
    Url.create(root_url: "www.jumpstartlabs.com")

    assert_equal [], Url.all.to_a
  end

  def test_it_doesnt_save_url_with_invalid_root_url
    Url.create(path: "/example")

    assert_equal [], Url.all.to_a
  end

end
