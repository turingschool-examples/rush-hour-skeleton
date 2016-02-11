require_relative '../test_helper'

class ClientAnalyzerTest < Minitest::Test
  attr_reader :analyzer
  include TestHelpers

  def setup
    @analyzer = ClientAnalyzer.new
    super
  end

  def test_client_parser
    index = 1
    request = {identifier: "thing#{index}", rootUrl: "www.another_thing.com#{index}"}
    analyzer.parse(request)
    assert_equal "thing1", Client.find_by(identifier: "thing1").identifier
  end

  def test_returns_error_on_invalid_client_creation
    request = {identifier: "thing"}
    error = analyzer.parse(request)
    assert_equal "Root url can't be blank", error
  end

end
