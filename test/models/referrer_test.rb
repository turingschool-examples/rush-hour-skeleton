class ReferrerTest < Minitest::Test

  def test_it_has_a_name
    referrer = Referrer.create(name: "http://jumpstartlab.com")
    assert_equal "http://jumpstartlab.com", referrer.name
  end

  def test_it_has_payloads
    referrer = Referrer.create(name: "http://jumpstartlab.com")
    assert_equal [], referrer.payloads
  end

end
