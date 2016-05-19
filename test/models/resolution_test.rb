require_relative "../test_helper"

class ResolutionTest < Minitest::Test
  include TestHelpers
  def test_validations_work
    resolution = Resolution.create({
        resolution_width: "Lucy's BADDDDDD boys",
        resolution_height: "idjkjdf"})
    assert resolution.valid?
  end

  def test_empty_string_is_invalid
    resolution = Resolution.create({
        resolution_width: "",
        resolution_height: ""})
    assert resolution.invalid?
  end

  def test_nil_is_invalid
    resolution = Resolution.create({
        resolution_width: nil,
        resolution_height: nil})
    assert resolution.invalid?
  end


  def test_no_info_is_invalid
    resolution = Resolution.create
    assert resolution.invalid?
  end

  def test_it_has_relationship_with_payload_request
    r = Resolution.new
    assert_respond_to(r, :payload_requests)
  end
end
