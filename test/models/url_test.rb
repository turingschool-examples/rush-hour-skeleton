require_relative "../test_helper"

class UrlTest < Minitest::Test

  def test_it_has_relationship_with_payload_request
    url = Url.new
    assert_respond_to(url, :payload_requests)
  end

  def test_validations_work
    url = Url.create({
        url: "Lucy's BADDDDDD boys"
      })
    assert url.valid?
  end

  def test_empty_string_is_invalid
    url = Url.create({
        url: ""
      })
    assert url.invalid?
  end

  def test_nil_is_invalid
    url = Url.create({
        url: nil
      })
    assert url.invalid?
  end

  def test_no_info_is_invalid
    url = Url.create
    assert url.invalid?
  end

end
