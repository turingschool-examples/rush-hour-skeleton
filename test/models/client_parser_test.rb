require './test/test_helper'

module TrafficSpy
  class ClientParserTest < Minitest::Test 

    def test_it_can_parse_an_identifier
      data    = {"identifier" => "jumpstartlab"} 
      result  = ClientParser.parse(data)
      assert_equal "jumpstartlab", result[:identifier]
    end

    def test_it_can_parse_a_root_url
      data    = {"rootUrl" => "http://jumpstartlab.com"}
      result  = ClientParser.parse(data)
      assert_equal "http://jumpstartlab.com", result[:root_url]
    end

    def test_it_can_parse_an_identifier_and_root_url
      data    = {"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com"}
      result  = ClientParser.parse(data)
      assert_equal "jumpstartlab", result[:identifier]
      assert_equal "http://jumpstartlab.com", result[:root_url]
    end

    def test_it_can_parse_an_empty_data_set
      data = {}
      result  = ClientParser.parse(data)
      assert_equal nil, result[:identifier]
      assert_equal nil, result[:root_url]
    end

    def test_it_can_parse_with_no_input
      result  = ClientParser.parse
      assert_equal nil, result[:identifier]
      assert_equal nil, result[:root_url]
    end

  end
end