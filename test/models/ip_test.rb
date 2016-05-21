require_relative '../test_helper'

class IpTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_partial_information_is_entered
    ip = Ip.new({ })
    refute ip.save
  end

  def test_it_returns_true_when_all_information_is_entered
    ip = Ip.new({ address: "ips!"})
    assert ip.save
  end

end
