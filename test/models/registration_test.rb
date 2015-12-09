require_relative '../test_helper'

class RegistrationParserTest < TrafficTest

  def setup
    params = {"rootUrl"=>"http://turing.io", "identifier"=>"turing"}
    @parser = TrafficSpy::RegistrationParser.new(params)
  end

  def test_identity_parses_correctly

    assert_equal "turing", @parser.identity
  end

end
