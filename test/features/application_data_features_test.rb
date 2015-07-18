require_relative '../test_helper'

class ApplicationDataTest < FeatureTest

  def test_it_renders_dashboard
    visit "/"
    # within("#title") do
    assert page.has_content?("Hello")

  end

end
