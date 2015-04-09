require './test/test_helper'

class IdentifierParserTest < Minitest::Test
  include Rack::Test::Methods

  def test_there_are_params
    data = nil
    assert_equal false, IdentifierParser.new.params_exist?(data)
  end

  def test_data_is_parsed
    data = {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    source = InputConverter.conversion(data)
    assert_equal "jumpstartlab", source[:identifier]
    assert_equal "http://jumpstartlab.com", source[:root_url]
  end

  def test_url_exist
    data = {"identifier"=>"jumpstartlab"}
    IdentifierParser.validate(data)
    # source = InputConverter.conversion(data)
    # source = Source.new(source)
    # IdentifierParser.new.check_for_keys(source)
    assert_equal "jumpstartlab", source[:identifier]
    source[:root_url]
    assert_equal 400, status
  end

end
