require_relative "../test_helper"

class IpTest < Minitest::Test
  include TestHelpers

  def setup
    @ip1 = Ip.create({:address => "66.77.44.1010"})
    @ip2 = Ip.create({:address => ""})
  end

  def test_it_validates_new_ip_with_all_fields
    assert @ip1.valid?
  end

  def test_it_does_not_validate_new_ip_with_missing_fields
    refute @ip2.valid?
  end

end
