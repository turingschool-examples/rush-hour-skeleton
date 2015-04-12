require 'byebug'
require './test/test_helper'

class UrlTest < Minitest::Test

  def test_has_many_payloads
    new_url = Url.create(url: "si.com")
    payload = new_url.payloads.create(ip: 123)
    assert 1, Payload.count
  end

end
