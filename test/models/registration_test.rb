require_relative '../test_helper'

class RegistrationTest < Minitest::Test

  def test_registration_has_many_urls
    registration = Registration.new(identifier: "myspace", url: "facebook.com")
    assert_equal [], registration.urls
  end


  def test_registration_returns_one_URL
    registration = Registration.new(identifier: "myspace", url: "facebook.com")
    Url.create(url: "googleplus.com")
    assert_equal ["googleplus.com"], registration.urls
  end

  def test_registration_returns_many_URLs
    registration = Registration.new(identifier: "myspace", url: "facebook.com")
    Url.create(url: "googleplus.com")
    Url.create(url: "myspace")
    Url.create(url: "geocities.com")
    assert_equal ["googleplus.com", "myspace", "geocities.com"], registration.urls
  end

end
