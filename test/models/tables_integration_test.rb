require_relative '../test_helper'
require 'pry'

class TableIntegrationTest < Minitest::Test
  include TestHelpers

  def setup
    @payload = {
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700",
      "respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }
  end

  def test_it_creates_all_tables_with_valid_information
    DataParser.create(@payload)

    assert_equal 1, PayloadRequest.all.length
    assert_equal 1, RequestType.all.length
    assert_equal 1, TargetUrl.all.length
    assert_equal 1, ReferrerUrl.all.length
    assert_equal 1, Resolution.all.length
    assert_equal 1, UAgent.all.length
    assert_equal 1, Ip.all.length
  end

  def test_it_creates_target_url_relationships
    DataParser.create(@payload)
    pr = PayloadRequest.all.first

    assert_equal "http://jumpstartlab.com/blog", pr.target_url.name
  end

  def test_it_creates_requested_at_relationships
    DataParser.create(@payload)
    pr = PayloadRequest.all.first

    assert_equal "GET", pr.request_type.name
  end

  def test_it_links_user_agent_correctly
    DataParser.create(@payload)
    pr = PayloadRequest.all.first

    assert_equal "Chrome", pr.u_agent.browser
  end

end
