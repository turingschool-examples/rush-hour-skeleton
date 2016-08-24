require_relative '../test_helper'
require './app/models/ip'

class IpTest < ModelTest

  def test_it_validates_input
    ip = Ip.new({address: "test ip"})

    ip_sad = Ip.new({})
    assert ip.save
    refute ip_sad.save
  end

  def test_address_is_unique
    ip = Ip.new({address: "test ip"})

     ip.save

    ip = Ip.new({address: "test ip"})

    refute ip.save
  end
end
