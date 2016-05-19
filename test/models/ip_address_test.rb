require_relative "../test_helper"

class IpAddressTest < Minitest::Test
  include TestHelpers
  def test_validations_work
    ip = IpAddress.create({
        ip_address: "Lucy's BADDDDDD boys"
      })
    assert ip.valid?
  end

  def test_empty_string_is_invalid
    ip = IpAddress.create({
        ip_address: ""
      })
    assert ip.invalid?
  end

  def test_nil_is_invalid
    ip = IpAddress.create({
        ip_address: nil
      })
    assert ip.invalid?
  end


  def test_no_info_is_invalid
    ip = IpAddress.create
    assert ip.invalid?
  end

  def test_it_has_relationship_with_payload_request
    ip = IpAddress.new
    assert_respond_to(ip, :payload_requests)
  end
end
