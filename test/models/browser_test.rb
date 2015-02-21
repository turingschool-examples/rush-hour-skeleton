class BrowserTest < Minitest::Test

  def test_has_correct_attributes
    browser = Browser.create(name: "Chrome")
    assert_equal "Chrome", browser.name
  end

  def test_it_has_payloads
    browser = Browser.create(name: "Chrome")
    assert_equal [], browser.payloads
  end

end
