require_relative '../test_helper'

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

    assert_equal "http://jumpstartlab.com/", pr.target_url.name
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

  def test_request_type_assigns_ids_accordingly
    pr = DataParser.create(@payload)
    pr2 = DataParser.create(@payload2)
    pr3 = DataParser.create(@payload3)

    assert_equal true, pr.request_type.id == pr3.request_type.id
    assert_equal false, pr.request_type.id == pr2.request_type.id
    assert_equal 2, RequestType.all.length
  end

  def test_target_url_assigns_ids_accordingly
    pr = DataParser.create(@payload)
    pr2 = DataParser.create(@payload2)
    pr3 = DataParser.create(@payload3)

    assert_equal true, pr.target_url.id == pr3.target_url.id
    assert_equal false, pr.target_url.id == pr2.target_url.id
    assert_equal 2, TargetUrl.all.length
  end

  def test_referrer_url_assigns_ids_accordingly
    pr = DataParser.create(@payload)
    pr2 = DataParser.create(@payload2)
    pr3 = DataParser.create(@payload3)

    assert_equal false, pr.referrer_url.id == pr3.referrer_url.id
    assert_equal true, pr3.referrer_url.id == pr2.referrer_url.id
    assert_equal 2, ReferrerUrl.all.length
  end

  def test_resolution_assigns_ids_accordingly
    pr = DataParser.create(@payload)
    pr2 = DataParser.create(@payload2)
    pr3 = DataParser.create(@payload3)

    assert_equal true, pr.resolution.id == pr3.resolution.id
    assert_equal false, pr.resolution.id == pr2.resolution.id
    assert_equal 2, Resolution.all.length
  end

  def test_u_agent_assigns_ids_accordingly
    pr = DataParser.create(@payload)
    pr2 = DataParser.create(@payload2)
    pr3 = DataParser.create(@payload3)

    assert_equal true, pr.u_agent.id == pr3.u_agent.id
    assert_equal true, pr.u_agent.id == pr2.u_agent.id
    assert_equal 1, UAgent.all.length
  end

  def test_ip_assigns_ids_accordingly
    pr = DataParser.create(@payload)
    pr2 = DataParser.create(@payload2)
    pr3 = DataParser.create(@payload3)

    assert_equal false, pr.ip.id == pr3.ip.id
    assert_equal false, pr.ip.id == pr2.ip.id
    assert_equal 3, Ip.all.length
  end

end
