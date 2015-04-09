require './test/test_helper'

class SourceTest < Minitest::Test

  def test_source_has_payloads
    source = Source.create(identifier: "something", root_url: "http://example.com")
    assert_equal [], source.payloads
  end
end