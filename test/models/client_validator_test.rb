require './test/test_helper'

module TrafficSpy
  class ClientValidatorTest < Minitest::Test 

    def setup
      DatabaseCleaner.start
    end

    def test_it_can_save_a_new_client
      data     = {"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com"}
      result   = ClientValidator.validate(data)
      expected = {:code=>200, :message=>"{\"identifier\":\"jumpstartlab\"}"}
      assert_equal expected, result 
    end

    def test_it_returns_error_for_repeat_identifier
      data     = {"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com"}
      ClientValidator.validate(data)
      result   = ClientValidator.validate(data)
      expected = {:code=>403, :message=>["Identifier has already been taken"]}
      assert_equal expected, result 
    end

    def test_it_returns_error_for_missing_url
      data     = {"identifier" => "jumpstartlab"}
      result   = ClientValidator.validate(data)
      expected = {:code=>400, :message=>["Root url can't be blank"]}
      assert_equal expected, result
    end

    def test_it_returns_error_for_missing_identifier
      data     = {"rootUrl" => "http://jumpstartlab.com"}
      result   = ClientValidator.validate(data)
      expected = {:code=>400, :message=>["Identifier can't be blank"]}
      assert_equal expected, result 
    end

    def test_it_returns_error_for_missing_identifier_and_missing_root_url
      data     = {}
      result   = ClientValidator.validate(data)
      expected = {:code=>400, :message=>["Identifier can't be blank", "Root url can't be blank"]}
      assert_equal expected, result 
    end

    def teardown
      DatabaseCleaner.clean
    end

  end
end