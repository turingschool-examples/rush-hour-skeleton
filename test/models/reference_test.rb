require_relative "../test_helper"

class ReferenceTest < Minitest::Test
  include TestHelpers
  def test_validations_work
    reference = Reference.create({
        reference: "Lucy's BADDDDDD boys"
      })
    assert reference.valid?
  end

  def test_empty_string_is_invalid
    reference = Reference.create({
        reference: ""
      })
    assert reference.invalid?
  end

  def test_nil_is_invalid
    reference = Reference.create({
        reference: nil
      })
    assert reference.invalid?
  end


  def test_no_info_is_invalid
    event = Reference.create
    assert event.invalid?
  end
  def test_it_has_relationship_with_payload_request
    r = Reference.new
    assert_respond_to(r, :payload_requests)
  end
end
