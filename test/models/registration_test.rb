require_relative '../test_helper'

class RegistrationTest < Minitest::Test

  def test_registration_has_many_urls
    registration = Registration.new(identifier: "myspace", url: "facebook.com")
    registration.save
    assert_equal 0, registration.urls.size
  end


  def test_registration_returns_one_URL
    registration = Registration.new(identifier: "myspace", url: "facebook.com")
    registration.save
    registration.payloads.create(url: Url.find_or_create_by({url: "googleplus.com"}))
    assert_equal 1, registration.urls.size
  end

  def test_registration_returns_many_URLs
    registration = Registration.new(identifier: "myspace", url: "facebook.com")
    registration.save
    registration.payloads.create(url: Url.find_or_create_by({url: "googleplus.com"}))
    registration.payloads.create(url: Url.find_or_create_by({url: "myspace"}))
    registration.payloads.create(url: Url.find_or_create_by({url: "geocities.com"}))
    assert_equal 3, registration.urls.size
  end

end
