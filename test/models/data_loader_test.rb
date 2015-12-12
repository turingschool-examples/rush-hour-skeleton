require './test/test_helper'

class DataLoaderTest < ModelTest
  def setup_one_payload
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

  def test_data_loader_turns_strings_into_corresponding_database_ids
    original_data = setup_one_payload

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
end
