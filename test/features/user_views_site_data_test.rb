require_relative "../test_helper"

class UserViewsSiteDataTest < FeatureTest

  def setup
    DatabaseCleaner.start
    source_seed_data = { identifier: "jumpstartlab",
               root_url: "http://jumpstartlab.com" }
    Source.create(source_seed_data)
    payload_hash
    payload_hash("2",2)
    payload_hash("3")
    url_seed_data = { address: "http://jumpstartlab.com/blog",
                      source_id: 1,
                      visits_count: 2,
                      average_response_time: 46 }
    url_seed_data2 = { address: "http://jumpstartlab.com/about",
                       source_id: 1,
                       visits_count: 1,
                       average_response_time: 37 }
    Url.create(url_seed_data)
    Url.create(url_seed_data2)
  end

  def teardown
    DatabaseCleaner.clean
  end

  def payload_hash(sha_id = "1", url_id = 1)
    params = {url_id: url_id,
               requested_at: "2013-02-16 21:38:28 -0700",
               responded_in: 37,
               referred_by: "http://jumpstartlab.com",
               request_type: "GET",
               parameters: [],
               event_name: "socialLogin",
               user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
               resolution_width: "1920",
               resolution_height: "1280",
               ip: "63.29.38.211",
               source_id: 1,
               sha_identifier: sha_id}
    Visit.create(params)
  end

  def test_user_sees_aggregate_data
    visit "/sources/jumpstartlab"

    assert_equal "/sources/jumpstartlab", current_path

    within(".page-header") do
      assert page.has_content?("Jumpstartlab Site Data")
    end

    within("#urls") do
      assert page.has_content?("Requested URLs")
      assert page.has_content?("http://jumpstartlab.com/blog: 2 visits")
      assert page.has_content?("http://jumpstartlab.com/about: 1 visits")
    end

    within("#browsers") do
      assert page.has_content?("Web Browser Breakdown")
      assert page.has_content?("Chrome: 3")
    end

    within("#os") do
      assert page.has_content?("OS Breakdown")
      assert page.has_content?("Macintosh: 3")
    end

    within("#screen_resolutions") do
      assert page.has_content?("Screen Resolutions")
      assert page.has_content?("1920x1280")
    end

    within("#response_times") do
      assert page.has_content?("URL Average Response Times")
      assert page.has_content?("http://jumpstartlab.com/blog: 46ms")
      assert page.has_content?("http://jumpstartlab.com/about: 37ms")
      assert find_link("http://jumpstartlab.com/blog").visible?
      assert find_link("http://jumpstartlab.com/about").visible?
    end

    within("#events_link") do
      assert find_link("Events").visible?
    end
  end

  def test_user_sees_error_message_when_identifier_does_not_exist
    visit "/sources/jumpstartlabsss"

    assert_equal "/sources/jumpstartlabsss", current_path
    assert page.has_content?("Error Page")
    assert page.has_content?("The identifier jumpstartlabsss does not exist")
  end

end
