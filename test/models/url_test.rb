require 'byebug'
require './test/test_helper'

class UrlTest < Minitest::Test

  def test_has_many_payloads
    new_url = Url.create(url: "si.com")
    payload = Payload.create(url: "espn.com")
    # assert 1, Payload.count
  end

end
