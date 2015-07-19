require_relative '../test_helper'

class ApplicationDataTest < FeatureTest

  def setup
  RegistrationHandler.new({"identifier"=>"jumpstartlab", "rootUrl"=>"jumpstartlab.com"})
  end

  def test_it_renders_homepage
    visit "/"

    assert page.has_content?("Traffic Spy")
  end

  def test_it_renders_most_visited_urls_for_the_specified_identifier
    visit "/sources/jumpstartlab"

    assert page.has_content?("Most Visited Webpages")
  end

  def test_it_renders_most_used_browsers_for_the_specified_identifier
    visit "/sources/jumpstartlab"

    assert page.has_content?("Most Used Browsers")
  end

  def test_it_renders_most_used_os_for_the_specified_identifier
    visit "/sources/jumpstartlab"

    assert page.has_content?("Most Used Operating System")
  end

  def test_it_renders_most_used_screen_resolutions_for_the_specified_identifier
    visit "/sources/jumpstartlab"

    assert page.has_content?("Most Used Screen Resolutions")
  end

  def test_it_renders_response_times_for_the_specified_identifier
    visit "/sources/jumpstartlab"

    assert page.has_content?("Average Response Time")
  end

  def test_it_renders_links_visited_for_the_specified_identifier
    visit "/sources/jumpstartlab"

    assert page.has_content?("Webpage Data")
    assert page.has_content?("Event Data Links")
  end

end
