class UrlTest < Minitest::Test

  def test_it_has_correct_attributes
    url = Url.create(address: "http://jumpstartlab.com/blog")
    assert_equal "http://jumpstartlab.com/blog", url.address
  end

  def test_it_has_payloads
    url = Url.create(address: "http://jumpstartlab.com/blog")
    assert_equal [], url.payloads
  end
end
