require_relative '../test_helper'

class UserCanClickOnEventHours < FeatureTest
  include TestHelpers
	include Rack::Test::Methods

  def test_it_opens_the_correct_path
    register_client
    path = '/sources/jumpstartlab/events/socialLogin'
    visit path

    assert_equal path, current_path
  end

  def test_it_displays_the_page_title
    register_client
    data_with_relative_path
    path = '/sources/jumpstartlab/events/socialLogin'
    visit path

    assert_equal '/sources/jumpstartlab/events/socialLogin', current_path
    # save_and_open_page
    within("h1") do
      assert page.has_content?("HOURLY BREAKDOWN YO")
    end
  end

  def test_it_displays_the_correct_results
    register_client
    data_with_relative_path
    path = '/sources/jumpstartlab/events/socialLogin'
    visit path

    assert_equal path, current_path
    within("body") do
      assert page.has_content?  ("
                                  00: Number of socialLogins= 0
                                  01: Number of socialLogins= 0
                                  02: Number of socialLogins= 0
                                  03: Number of socialLogins= 0
                                  04: Number of socialLogins= 0
                                  05: Number of socialLogins= 0
                                  06: Number of socialLogins= 0
                                  07: Number of socialLogins= 0
                                  08: Number of socialLogins= 0
                                  09: Number of socialLogins= 0
                                  10: Number of socialLogins= 0
                                  11: Number of socialLogins= 0
                                  12: Number of socialLogins= 0
                                  13: Number of socialLogins= 0
                                  14: Number of socialLogins= 0
                                  15: Number of socialLogins= 0
                                  16: Number of socialLogins= 0
                                  17: Number of socialLogins= 0
                                  18: Number of socialLogins= 0
                                  19: Number of socialLogins= 0
                                  20: Number of socialLogins= 0
                                  21: Number of socialLogins= 2
                                  22: Number of socialLogins= 0
                                  23: Number of socialLogins= 0
                                  ")
    end
  end

  def test_bad_event_shows_event_not_found_and_a_link_to_the_events_index_page
    register_client
    data_with_relative_path
    path = '/sources/jumpstartlab/events/socialLogi'
    visit path

    assert_equal path, current_path
    within("h1") do
      assert page.has_content?("Event not found")
    end

    within("a") do
      assert page.has_content?("Events Index")
    end

    click_link "Events Index"
    assert_equal "/sources/jumpstartlab/events", current_path
  end


end
