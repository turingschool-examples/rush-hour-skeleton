require_relative '../test_helper'

class ApplicationDataTest < FeatureTest

  def test_it_renders_dashboard
    visit "/"
    assert page.has_content?("Hello")
  end

end
