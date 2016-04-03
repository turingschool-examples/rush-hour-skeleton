require_relative '../test_helper'

class UserCanClickOnEventHours < FeatureTest
  include TestHelpers
	include Rack::Test::Methods

  def test_it_opens_the_correct_path
    path = '/sources/jumpstartlab/events/socialLogin'
    visit path

    assert_equal path, current_path
  end

  def test_it_displays_the_page_title
    skip
    path = '/sources/jumpstartlab/events/socialLogin'
    visit path

    assert_equal '/sources/jumpstartlab/events/socialLogin', current_path
    save_and_open_page
    within("h1") do
      assert page.has_content?("HOURLY BREAKDOWN YO")
    end
  end

  def test_it_displays_the_correct_results
    skip
    path = '/sources/jumpstartlab/events/socialLogin'
    visit path

    assert_equal path, current_path

    within("h2") do
      assert page.has_content?  ("00: Number of socialLogins= 8
                                  01: Number of socialLogins= 0
                                  02: Number of socialLogins= 0
                                  03: Number of socialLogins= 1
                                  04: Number of socialLogins= 1
                                  05: Number of socialLogins= 0
                                  06: Number of socialLogins= 0
                                  07: Number of socialLogins= 0
                                  08: Number of socialLogins= 0
                                  09: Number of socialLogins= 1
                                  10: Number of socialLogins= 1
                                  11: Number of socialLogins= 0
                                  12: Number of socialLogins= 2
                                  13: Number of socialLogins= 0
                                  14: Number of socialLogins= 2
                                  15: Number of socialLogins= 1
                                  16: Number of socialLogins= 0
                                  17: Number of socialLogins= 0
                                  18: Number of socialLogins= 1
                                  19: Number of socialLogins= 0
                                  20: Number of socialLogins= 1
                                  21: Number of socialLogins= 7
                                  22: Number of socialLogins= 2
                                  23: Number of socialLogins= 1")
    end
  end

  def test_bad_event_shows_event_not_found_and_a_link_to_the_events_index_page
    skip
    path = '/sources/jumpstartlab/events/socialLogin'
    visit path

    assert_equal path, current_path
    within("h1") do
      assert page.has_content?("Event not Found")
      assert page.has_content?("Events Index")
      click_link "Events Index"
      assert_equal "/sources/jumpstartlab/events/eventIndex", current_path
    end
  end


end
