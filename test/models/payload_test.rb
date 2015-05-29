require_relative '../test_helper'

class PayloadTest < Minitest::Test
  def test_valid_attributes
    #need to add other attributes after we create tables for it
    payload = Payload.create({requested_at: "2013-02-16 21:38:28 -0700"})

    assert_equal "2013-02-16 21:38:28 -0700", payload.requested_at
  end

  def test_valid_uniqueness_of_requested_at
    payload_one = Payload.create({requested_at: "2013-02-16 21:38:28 -0700"})
    payload_two = Payload.create({requested_at: "2013-02-16 21:38:28 -0700"})

    assert payload_one.valid?
    refute payload_two.valid?
    assert_equal 1, Payload.count
  end

  def test_invalid_without_requested_at
    payload = Payload.create

    refute payload.valid?
  end
end
