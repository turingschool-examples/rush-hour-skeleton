class UrlDataTest < FeatureTest

  def test_user_can_see_longest_response_time_for_the_url 
    visit '/sources/jumpstartlab/jumpstartlab.com/blog'
    assert_equal '/sources/jumpstartlab/jumpstartlab.com/blog', current_path
    assert page.has_content?("Longest response:")
    assert page.has_content?("37")
  end

# As a user
# When i visit "/sources/identifier/(some_url)" 
# I should see longest response time for that URL

end