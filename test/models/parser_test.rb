require_relative "../test_helper"

class ParserTest < Minitest::Test
  include Parser

  def setup
    @string = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "parameters":[],
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'
  end

  # def test_it_can_get_payload
  #   v = {
  #         "url": "http://jumpstartlab.com/blog",
  #         "requested_at": "dhbfkhsdij",
  #         "responded_in": 37,
  #         "referred_by": "http://jumpstartlab.com",
  #         "request_type": "GET",
  #         "parameters": [],
  #         "event_name": "socialLogin",
  #         "user_agent_id": "1",
  #         "resolution_id": "1",
  #         "ip": "63.29.38.211"
  #       }
  #   assert_equal v, get_payload({
  #                         "url": "http://jumpstartlab.com/blog",
  #                         "requested_at": "dhbfkhsdij",
  #                         "responded_in": 37,
  #                         "referred_by": "http://jumpstartlab.com",
  #                         "request_type": "GET",
  #                         "parameters": [],
  #                         "event_name": "socialLogin",
  #                         "user_agent_id": "1",
  #                         "resolution_id": "1",
  #                         "ip": "63.29.38.211"
  #                         })
  # end


  def test_it_parses_json
    hash = {
              "url"=>"http://jumpstartlab.com/blog",
              "requestedAt"=>"2013-02-16 21:38:28 -0700",
              "respondedIn"=>37,
              "referredBy"=>"http://jumpstartlab.com",
              "requestType"=>"GET", "parameters"=>[],
              "eventName"=>"socialLogin", "userAgent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              "resolutionWidth"=>"1920", "resolutionHeight"=>"1280",
              "ip"=>"63.29.38.211"
            }
    assert_equal hash, json(@string)
  end

  def test_it_can_create_resolution_table
    resolution_table = parse_resolution(@string)
    assert_equal "1280", resolution_table.height
    assert_equal "1920", resolution_table.width
    assert_equal true, resolution_table.id.integer?
  end

  def test_it_can_create_user_agent_table
    user_agent_table = parse_user_agent(@string)
    assert_equal "Chrome", user_agent_table.browser
    assert_equal "24.0.1309.0", user_agent_table.version
    assert_equal "Macintosh", user_agent_table.platform
    assert_equal true, user_agent_table.id.integer?
  end

  def test_it_can_create_payload

  end
end
