class SourceTest < Minitest::Test

  def test_it_has_correct_attributes
    source = Source.create(rootUrl: "http://jumpstartlab.com/blog", identifier: "jumpstartlab")
    assert_equal "http://jumpstartlab.com/blog", source.rootUrl
    assert_equal "jumpstartlab", source.identifier
  end

  def test_it_has_payloads
    source = Source.create(rootUrl: "http://jumpstartlab.com/blog", identifier: "jumpstartlab")
    assert_equal [], source.payloads

  end
end
