require "./test/test_helper"

class EventIndexTest

  def test_url_has_correct_attributes
    url = Url.create(address: "http://kyrablog.com")
    assert_equal "http://kyrablog.com", url.address
    assert_equal 1, url.id
  end

  def test_url_has_many_payloads
    url = Url.create(address: "http://kyrablog.com")
    assert_equal [], url.payloads
  end

end
