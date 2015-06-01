require_relative '../test_helper'

class SourceTest < Minitest::Test
  def test_valid_with_identifier_and_root_url
    source = Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    assert_equal "jumpstartlab", source.identifier
    assert_equal "http://jumpstartlab.com", source.root_url
    assert source.valid?
  end

  def test_valid_uniqueness_of_identifier
    source_one = Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    source_two = Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    assert source_one.valid?
    refute source_two.valid?
    assert_equal 1, Source.count
  end

  def test_invalid_without_identifier
    source = Source.create(root_url: "http://jumpstartlab.com")

    refute source.valid?
  end

  def test_invalid_without_root_url
    source = Source.create(identifier: "jumpstartlab")

    refute source.valid?
  end

  def test_group_urls_will_return_ordered_nested_array_by_count_with_url
    Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0710"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/asdf", requested_at: "2013-02-16 21:38:28 -0720"})
    source = Source.find_by(identifier: "jumpstartlab")

    assert_equal "http://jumpstartlab.com/asdf", source.requested_urls.last[0]
    assert_equal 1, source.requested_urls.last[1]
    assert_equal "http://jumpstartlab.com/blog", source.requested_urls.first[0]
    assert_equal 2, source.requested_urls.first[1]
  end

  def test_average_times_will_return_ordered_nested_array_by_avg_time_with_url
    Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0701", responded_in: 10})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 20})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/asdf", requested_at: "2013-02-16 21:38:28 -0722", responded_in: 200})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/asdf", requested_at: "2013-02-16 21:38:28 -0723", responded_in: 199})
    source = Source.find_by(identifier: "jumpstartlab")

    assert_equal "http://jumpstartlab.com/asdf", source.average_times.first[0]
    assert_equal 199.5, source.average_times.first[1]
    assert_equal "http://jumpstartlab.com/blog", source.average_times.last[0]
    assert_equal 15.0, source.average_times.last[1]
  end

  def test_screen_resolution_breakdown
    source = Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })
    Payload.create({source_id: 1, resolution_width: "1920", resolution_height: "1280", requested_at: "2013-02-16 21:38:28 -0701"})
    Payload.create({source_id: 1, resolution_width: "800", resolution_height: "600", requested_at: "2013-02-16 21:38:28 -0702"})

    result = {["1920", "1280"]=>1, ["800", "600"]=>1}
    assert_equal result, source.screen_res
  end

  def test_returns_total_events_received
    source = Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })
    Payload.create({source_id: 1, event_name: "socialLogin", requested_at: "2013-02-16 21:38:28 -0701"})
    Payload.create({source_id: 1, event_name: "socialLogin", requested_at: "2013-02-16 21:38:28 -0702"})

    assert_equal 2, source.total_events_received("socialLogin")
  end

  def test_returns_event_hourly
    source = Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })
    Payload.create({source_id: 1, event_name: "socialLogin", requested_at: "2013-02-16 21:38:28 -0701"})
    Payload.create({source_id: 1, event_name: "socialLogin", requested_at: "2013-02-16 21:38:28 -0702"})

    assert_equal "12 am", source.event_hourly("socialLogin").keys.first
  end

  def test_http_routes_returns_array_of_unique_routes
    Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0701", responded_in: 13, request_type: "GET"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0704", responded_in: 13, request_type: "GET"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0702", responded_in: 13, request_type: "POST"})
    source = Source.find_by(identifier: "jumpstartlab")

    assert_equal 2, source.http_routes("http://jumpstartlab.com/blog").length
    assert source.http_routes("http://jumpstartlab.com/blog").one? { |el| el.request_type == 'GET'}
    assert source.http_routes("http://jumpstartlab.com/blog").one? { |el| el.request_type == 'POST'}
  end

  def test_top_referrer_returns_most_popular_referrer
    Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0701", responded_in: 13, request_type: "GET", referred_by: "asdf"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0704", responded_in: 13, request_type: "GET", referred_by: "asdf"})
    Payload.create({source_id: 1, url: "http://jumpstartlab.com/blog", requested_at: "2012-02-16 21:38:28 -0702", responded_in: 13, request_type: "POST", referred_by: "haha"})
    source = Source.find_by(identifier: "jumpstartlab")

    assert_equal "asdf", source.top_referrer("http://jumpstartlab.com/blog")
  end
end
