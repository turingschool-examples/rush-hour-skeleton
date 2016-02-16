require_relative '../test_helper'

class ReferrerUrlTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert ReferrerUrl
  end

  def test_can_create_referrer_url_through_payload_request
    url = create_payload_1

    assert_equal "http://www.jumpstartlab.com", ReferrerUrl.find(1).url_address
    assert_equal 1, url.url_id
  end

  def test_can_create_referrer_url
    ref = {url_address: "http://www.jumpstartlab.com"}
    ru = ReferrerUrl.create(ref)

    assert ru.valid?
    assert_equal "http://www.jumpstartlab.com", ru.url_address
    assert_equal 1, ReferrerUrl.all.count
  end

  def test_same_referrer_url_will_not_be_added_to_database
    ref = {url_address: "http://www.jumpstartlab.com"}
    ru = ReferrerUrl.create(ref)

    assert_equal 1, ReferrerUrl.all.count

    ref2 = {url_address: "http://www.jumpstartlab.com"}
    ru2 = ReferrerUrl.create(ref2)

    refute ru2.valid?
    assert ru2.id.nil?
    assert_equal 1, ReferrerUrl.all.count
  end
end
