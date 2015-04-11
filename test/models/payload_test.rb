require './test/test_helper'
require 'byebug'

class PayloadTest < Minitest::Unit::TestCase

  def test_uniqueness_validation_ip_as_requested_at
    assert_equal 0, Payload.count
    request1 = Payload.create!({ip: 2, requested_at: "today"})
    assert_equal 1, Payload.count
    request2 = Payload.new({ip: 2, requested_at: "today"})
    assert request2.invalid?
    assert_equal ["Application has already been received"], request2.errors[:ip]
  end

end
