require './test/test_helper'

class JsonParserTest < ControllerTest

  def test_parses_a_json_payload
    expected = {
        :url=>"http://jumpstartlab.com/blog", :requested_at=>"2013-02-16 21:38:28 -0700",
        :responded_in=>37, :referred_by=>"http://jumpstartlab.com", :request_type=>"GET", :parameters=>[],
        :event_name=>"socialLogin",
        :browser=>"Chrome",
        :platform=>"Macintosh",
        :resolution_width=>"1920", :resolution_height=>"1280", :ip=>"63.29.38.211"
    }

    assert_equal expected, JsonParser.parse(payload[:payload])
  end
end
