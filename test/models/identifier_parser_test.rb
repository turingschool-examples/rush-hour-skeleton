require_relative '../test_helper'
require './app/models/identifier_parser'

class PayloadParserTest < ModelTest
  def test_it_changes_camel_case_to_snake
    payload = {rootUrl: "www.example.com"}
    parser = IdentifierParser.new(payload)
    expected = {root_url: "www.example.com"}
    assert_equal expected, parser.replace_keys(payload)
  end

  def test_it_parses_a_param_string
    payload = {'identifier'=>'jumpstartlab', 'rootUrl'=>'http://jumpstartlab.com'}
    parser = IdentifierParser.new(payload)
    expected ={identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}
    assert_equal expected, parser.parse
  end
end
