require_relative '../test_helper'
require 'pry'

class TableIntegrationTest < Minitest::Test
  include TestHelpers

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

  def test_it_creates_request_type_relationships
    DataParser.create(@payload)
    pr = PayloadRequest.all.first

    assert_equal "GET", pr.request_type.name
  end

  def test_it_creates_target_url_relationships
    DataParser.create(@payload)
    pr = PayloadRequest.all.first

    assert_equal "http://jumpstartlab.com/blog", pr.target_url.name
  end

  def test_it_creates_referrer_url_relationships
    DataParser.create(@payload)
    pr = PayloadRequest.all.first

    assert_equal "http://jumpstartlab.com", pr.referrer_url.name
  end

  def test_it_creates_resolution_relationships
    DataParser.create(@payload)
    pr = PayloadRequest.all.first

    assert_equal "1920", pr.resolution.width
    assert_equal "1280", pr.resolution.height
  end

  def test_it_links_user_agent_correctly
    DataParser.create(@payload)
    pr = PayloadRequest.all.first

    assert_equal "Chrome",    pr.u_agent.browser
    assert_equal "Macintosh", pr.u_agent.os
  end

  def test_it_links_ip_correctly
    DataParser.create(@payload)
    pr = PayloadRequest.all.first

    assert_equal "63.29.38.211", pr.ip.address
  end
end
