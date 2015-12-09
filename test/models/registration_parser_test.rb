require_relative '../test_helper'

class RegistrationParserTest < TrafficTest

  def parser_setup(params)
    @parser = TrafficSpy::RegistrationParser.new(params)
  end

  def test_identity_parses_correctly
    parser_setup({"rootUrl"=>"http://turing.io", "identifier"=>"turing"})
    assert_equal "turing", @parser.identity
    assert_equal "http://turing.io", @parser.root
  end

  def test_status_and_body_returns
    expected_response = {'identifier' => "turing"}.to_json
    actual_response = parser_setup({"rootUrl"=>"http://turing.io", "identifier"=>"turing"}).parsing_validating
    assert_equal expected_response, actual_response
  end

  def test_status_and_body_returns_400_for_missing_details
    expected_response = [400, "Missing all required details."]
    actual_response = parser_setup({"rootUrl"=>"http://turing.io"}).parsing_validating
    assert_equal expected_response, actual_response
  end

  def test_returns_403_if_user_already_exists
    parser_setup({"rootUrl"=>"http://turing.io", "identifier"=>"turing"}).parsing_validating
    repeat = parser_setup({"rootUrl"=>"http://turing.io", "identifier"=>"turing"}).parsing_validating
    expected_response = [403, "Identifier already exists."]
    assert_equal expected_response, repeat
  end

end
