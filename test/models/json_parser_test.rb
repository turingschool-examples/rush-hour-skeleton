require './test/test_helper'

class JsonParserTest < ControllerTest

  def test_parses_a_json_payload
    expected = {
      :path=>"http://jumpstartlab.com/blog",
      :requested_at=>"2013-02-16 21:38:28 -0700",
      :responded_in=>37,
      :referred_by=>"http://jumpstartlab.com",
      :request_type=>"GET",
      :event_name=>"socialLogin",
      :resolution_width=>"1920",
      :resolution_height=>"1280",
      :browser=>"Chrome",
      :platform=>"Macintosh" }

    assert_equal expected, JsonParser.parse(payload[:payload])
  end
end
