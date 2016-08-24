require_relative '../test_helper'

class BrowserTest < Minitest::Test
  include TestHelpers

  def test_it_can_be_created_with_browser_name
    data = { name: "Mozilla/5.0"}
    browser = Browser.create(data)

    assert_equal "Mozilla/5.0", browser.name
    assert browser.valid?
  end

  def test_it_is_not_valid_if_no_name_is_given
    data = { name: nil}
    browser = Browser.create(data)

    assert_equal nil, browser.name
    refute browser.valid?
  end

end
