require_relative '../test_helper'

class SourcesFeatureTest < FeatureTest

  def test_it_renders_the_application_registration_page
  visit "/sources"

  assert page.has_content?("Register an Application:")
  end

  def test_it_renders_the_name_field
    visit "/sources"

    assert page.has_content?("Website Identifier")
  end

  def test_it_renders_the_website_field
    visit "/sources"

    assert page.has_content?("Website Domain")
  end
end
