require_relative '../test_helper'
require './app/models/ip'

class IpTest < Minitest::Test
  def test_it_validates_input
    ip = Ip.new({ip: "test ip"})

    ip_sad = Ip.new({})
    assert ip.save
    refute ip_sad.save
  end
end