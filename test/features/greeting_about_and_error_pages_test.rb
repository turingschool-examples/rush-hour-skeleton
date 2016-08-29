require './test/test_helper'
class GreetingPageTest < FeatureTest
  def test_it_greets_visitors
    visit '/sources'
    assert page.has_content?("Welcome to Rush Hour")
  end
end

class AboutPageTest < FeatureTest
  def test_about_page_describes_project
    visit '/about'
    assert page.has_content?("About Rush Hour")
  end
end

class ErrorPageTest < FeatureTest
  def test_error_pages_exist
    visit '/'
    assert page.has_content?("Error Page")
  end
end
