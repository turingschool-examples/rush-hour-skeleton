require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def setup
    url = Url.create(address: @payload[:url])

    @payload = {
        "url": url.id,
        "requestedAt": "2013-02-16 21:38:28 -0700",
        "respondedIn": 37,
        "referredBy": "http://jumpstartlab.com",
        "requestType": "GET",
        "parameters":[],
        "eventName": "socialLogin",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth": "1920",
        "resolutionHeight": "1280",
        "ip": "63.29.38.211"
      }

      # require 'pry'; binding.pry

  end

  def test_it_can_accept_pr
    pr = PayloadRequest.create(@payload)

    assert_equal "http://jumpstartlab.com", pr.url
  end

  # def test_it_checks_for_empty_address
  #   pr = PayloadRequest.create(address: nil)
  #
  #   assert_nil pr.address
  # end
  #
  # def test_it_responds_with_an_error_message
  #   pr = PayloadRequest.create(address: nil)
  #
  #   assert_equal "can't be blank", pr.errors.messages[:address][0]
  # end
end
