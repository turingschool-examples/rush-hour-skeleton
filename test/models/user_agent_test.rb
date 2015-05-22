require 'byebug'
require './test/test_helper'

class UserAgentTest < Minitest::Test

  def test_has_many_payloads
    new_useragent = UserAgent.create(web_browser: "firefox")
    payload = new_useragent.payloads.create(ip: 123)
    assert 1, Payload.count
  end

  def test_has_many_screen_resolutions
    new_useragent = UserAgent.create(web_browser: "firefox")
    payload = new_useragent.screen_resolutions.create(resolution_width: 123, resolution_height: 321)
    assert 1, ScreenResolution.count
  end

end
