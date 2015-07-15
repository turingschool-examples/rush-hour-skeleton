require './test/test_helper.rb'

class MostRequestedURLTest < ControllerTest

  def test_user_can_view_most_to_least_requested_urls
    visit "/sources/jumpstartlab"
    within("#most_requested_urls") do
      assert page.has_content?("li", count: 3)

    end


  end



end