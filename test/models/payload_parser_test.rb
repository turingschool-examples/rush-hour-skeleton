require './test/test_helper'

module TrafficSpy
  class PayloadParserTest < Minitest::Test 

    def payload
      {"url"=>"http://jumpstartlab.com/blog","requestedAt"=>"2013-02-16 21:38:28 -0700","respondedIn"=>37,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>[],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"1920","resolutionHeight"=>"1280","ip"=>"63.29.38.211"}.to_json
    end

    def parsed_payload
      {:parameters=>nil, :responded_in=>37, :requested_at=>"2013-02-16 21:38:28 -0700", :address_id=>1, :agent_id=>1, :client_id=>nil, :event_id=>1, :referer_id=>1, :request_id=>1, :resolution_id=>1, :tracked_site_id=>1, :composite_key=>"ff733769a8e1783baaae73f1e16b0a9b31663ffc"}
    end

    def nil_payload
      {:parameters=>nil, :responded_in=>nil, :requested_at=>nil, :address_id=>nil, :agent_id=>nil, :client_id=>nil, :event_id=>nil, :referer_id=>nil, :request_id=>nil, :resolution_id=>nil, :tracked_site_id=>nil, :composite_key=>nil}
    end

    def test_it_can_parse_a_full_payload
      payload_result = PayloadParser.parse(payload, "jumpstartlab")  
      assert_equal parsed_payload, payload_result
    end

    def test_it_can_parse_a_nil_payload
      payload_result = PayloadParser.parse(nil, "jumpstartlab")  
      assert_equal nil_payload, payload_result
    end

  end
end