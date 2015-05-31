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

    assert_equal "http://jumpstartlab.com/asdf", source.group_urls.last[0]
    assert_equal 1, source.group_urls.last[1]
    assert_equal "http://jumpstartlab.com/blog", source.group_urls.first[0]
    assert_equal 2, source.group_urls.first[1]
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

  # def test_screen_resolution_breakdown
  #   source = Source.create({identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" })
  #   Payload.create({source_id: 1, resolution_width: "1920", resolution_height: "1280", requested_at: "2013-02-16 21:38:28 -0701"})
  #   Payload.create({source_id: 1, resolution_width: "800", resolution_height: "600", requested_at: "2013-02-16 21:38:28 -0702"})
  #   p Source.screen_res
  #   assert_equal {["1920", "1280"], 1}; {["800", "600"], 1}, source.screen_res
  # end

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

    assert_equal 2, source.total_events_received("socialLogin")
  end
end
