class ReferredByTest < Minitest::Test

  def test_it_has_a_name
    referred_by = ReferredBy.create(name: "http://jumpstartlab.com")
    assert_equal "http://jumpstartlab.com", referred_by.name
  end

  def test_it_has_payloads
    referred_by = ReferredBy.create(name: "http://jumpstartlab.com")
    assert_equal [], referred_by.payloads
  end

end
