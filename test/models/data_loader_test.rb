require './test/test_helper'

class DataLoaderTest < ModelTest
  def setup_payload_one
    {
      relative_path_string: "/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"GET",
      event_string: "socialLogin",
      operating_system_string: "Macintosh",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }
  end

  def setup_payload_two
    {
      relative_path_string: "/about",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by:"http://turing.io",
      request_type_string:"POST",
      event_string: "socialShare",
      operating_system_string: "Windows",
      browser_string: "Firefox",
      resolution_string: {width: "800", height: "600"},
      ip_address:"63.29.38.211"
    }
  end

  def setup_payload_three
    {
      relative_path_string: "/about",
      requested_at: "2013-02-17 21:38:28 -0700",
      responded_in: 40,
      referred_by:"http://turing.io",
      request_type_string:"POST",
      event_string: "socialLogin",
      operating_system_string: "Windows",
      browser_string: "Chrome",
      resolution_string: {width: "1920", height: "1280"},
      ip_address:"63.29.38.211"
    }
  end

  def test_data_loader_turns_strings_into_corresponding_database_ids
    original_data = setup_payload_one

    loader = TrafficSpy::DataLoader.new(original_data)

    expected = {
      relative_path_id: 1,
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://turing.io",
      request_type_id: 1,
      event_id: 1,
      operating_system_id: 1,
      browser_id: 1,
      resolution_id: 1,
      ip_address:"63.29.38.211"
    }

    assert_equal expected, loader.find_ids
  end

  def test_creates_new_ids_for_two_different_payloads
    data_1 = setup_payload_one
    data_2 = setup_payload_two

    loader_1 = TrafficSpy::DataLoader.new(data_1)
    loader_2 = TrafficSpy::DataLoader.new(data_2)

    expected_1 = {
      relative_path_id: 1,
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://turing.io",
      request_type_id: 1,
      event_id: 1,
      operating_system_id: 1,
      browser_id: 1,
      resolution_id: 1,
      ip_address:"63.29.38.211"
    }

    expected_2 = {
      relative_path_id: 2,
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://turing.io",
      request_type_id: 2,
      event_id: 2,
      operating_system_id: 2,
      browser_id: 2,
      resolution_id: 2,
      ip_address:"63.29.38.211"
    }

    assert_equal expected_1, loader_1.find_ids
    assert_equal expected_2, loader_2.find_ids
  end

  def test_finds_ids_of_objects_already_in_table
    data_1 = setup_payload_one
    data_2 = setup_payload_three

    loader_1 = TrafficSpy::DataLoader.new(data_1)
    loader_2 = TrafficSpy::DataLoader.new(data_2)

    expected_1 = {
      relative_path_id: 1,
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://turing.io",
      request_type_id: 1,
      event_id: 1,
      operating_system_id: 1,
      browser_id: 1,
      resolution_id: 1,
      ip_address:"63.29.38.211"
    }

    expected_2 = {
      relative_path_id: 2,
      requested_at: "2013-02-17 21:38:28 -0700",
      responded_in: 40,
      referred_by: "http://turing.io",
      request_type_id: 2,
      event_id: 1,
      operating_system_id: 2,
      browser_id: 1,
      resolution_id: 1,
      ip_address:"63.29.38.211"
    }

    assert_equal expected_1, loader_1.find_ids
    assert_equal expected_2, loader_2.find_ids
  end
end
