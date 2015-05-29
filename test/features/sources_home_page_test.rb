require 'minitest/autorun'
require 'minitest/pride'
require_relative '../test_helper'


class FeatureTest < Minitest::Test
  include Capybara::DSL
end

class SourceHomePage < FeatureTest
  def test_can_view_data
    visit '/sources/:identifier'
    assert page.has_content?(':identifier')

    #
    # fill_in "skill[title]", with: "skill1"
    # fill_in "skill[description]", with: "juggling"
    # click_button "submit"
    # assert_equal "/skills", current_path
    # assert page.has_content?("skill1")
  end
end
