require './test/test_helper'

module TrafficSpy
  class PayloadValidatorTest < Minitest::Test 

    def setup
      DatabaseCleaner.start
    end

    def payload
      {"payload" => {"url"=>"http://jumpstartlab.com/blog","requestedAt"=>"2013-02-16 21:38:28 -0700","respondedIn"=>37,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>[],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"1920","resolutionHeight"=>"1280","ip"=>"63.29.38.211"}.to_json}
    end

    def test_it_can_save_a_new_payload
      result   = PayloadValidator.validate(payload["payload"], "jumpstartlab")
      expected = {:code=>200}
      assert_equal expected, result 
    end

    def test_it_returns_error_for_repeat_payload
      PayloadValidator.validate(payload["payload"], "jumpstartlab")
      result   = PayloadValidator.validate(payload["payload"], "jumpstartlab")
      expected = {:code=>403, :message=>["Cannot save. Duplicate payload"]}
      assert_equal expected, result 
    end

    def teardown
      DatabaseCleaner.clean
    end

  end
end