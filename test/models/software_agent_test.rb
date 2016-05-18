require_relative "../test_helper"

class SoftwareAgentTest < Minitest::Test
  def test_validations_work
    user = SoftwareAgent.create({
        os: "Lucy's BADDDDDD boys",
        browser: "idjkjdf"})
    assert user.valid?
  end

  def test_empty_string_is_invalid
    user = SoftwareAgent.create({
        os: "",
        browser: ""})
    assert user.invalid?
  end

  def test_nil_is_invalid
    user = SoftwareAgent.create({
        os: nil,
        browser: nil})
    assert user.invalid?
  end


  def test_no_info_is_invalid
    user = SoftwareAgent.create
    assert user.invalid?
  end


  def test_it_has_relationship_with_payload_request
    u = SoftwareAgent.new
    assert_respond_to(u, :payload_requests)
  end
end
