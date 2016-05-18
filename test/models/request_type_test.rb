require_relative "../test_helper"

class RequestTypeTest < Minitest::Test
  include TestHelpers
  def test_validations_work
    request = RequestType.create({
        request_type: "Lucy's BADDDDDD boys"
      })
    assert request.valid?
  end

  def test_empty_string_is_invalid
    request = RequestType.create({
        request_type: ""
      })
    assert request.invalid?
  end

  def test_nil_is_invalid
    request = RequestType.create({
        request_type: nil
      })
    assert request.invalid?
  end

  def test_no_info_is_invalid
    request = RequestType.create
    assert request.invalid?
  end

  def test_it_has_relationship_with_payload_request
    r = RequestType.new
    assert_respond_to(r, :payload_requests)
  end

  def test_all_verbs
    payloads = create_payloads(1)
    payloads.each {|payload| PayloadParser.new(payload)}
    verb = RequestType.find(1).request_type
    assert_equal [verb], RequestType.all_verbs
  end

  def test_it_finds_most_frequent_request_type
    payloads = create_payloads(4)
    payloads.each {|payload| PayloadParser.new(payload)}
    RequestType.all_verbs.each do |verb|
      puts verb
    end
    assert_equal "", RequestType.most_frequent_request_verbs
  end
end
