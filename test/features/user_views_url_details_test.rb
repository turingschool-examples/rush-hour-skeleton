require './test/test_helper'

class UserViewsURLDetails < FeatureTest

  def test_the_page_displays_the_longest_response_time
    skip
    visit 'http://localhost:9393/sources/IDENTIFIER/urls/RELATIVE/PATH'
    assert_equal '/sources/IDENTIFIER/urls/RELATIVE/PATH', current_path
    within('#response-time') do
      assert page.has_content?('Longest Response Time:')
    end
  end

  def test_the_page_displays_the_shortest_response_time
    skip
    visit 'http://localhost:9393/sources/IDENTIFIER/urls/RELATIVE/PATH'
    assert_equal '/sources/IDENTIFIER/urls/RELATIVE/PATH', current_path
    within('#response-time') do
      assert page.has_content?('Shortest Response Time:')
    end
  end

  def test_the_page_displays_the_average_response_time
    skip
    visit 'http://localhost:9393/sources/IDENTIFIER/urls/RELATIVE/PATH'
    assert_equal '/sources/IDENTIFIER/urls/RELATIVE/PATH', current_path
    within('#response-time') do
      assert page.has_content?('Average Response Time:')
    end
  end

  def test_the_page_displays_http_verbs
    skip
    visit 'http://localhost:9393/sources/IDENTIFIER/urls/RELATIVE/PATH'
    assert_equal '/sources/IDENTIFIER/urls/RELATIVE/PATH', current_path
    within('#http-verbs') do
      assert page.has_content?('HTTP Verbs')
    end
  end

  def test_the_page_displays_most_popular_referrers
    skip
    visit 'http://localhost:9393/sources/IDENTIFIER/urls/RELATIVE/PATH'
    assert_equal '/sources/IDENTIFIER/urls/RELATIVE/PATH', current_path
    within('#http-verbs') do
      assert page.has_content?('Most Popular Referrers:')
    end
  end


  def test_the_page_displays_most_popular_user_agents
    skip
    visit 'http://localhost:9393/sources/IDENTIFIER/urls/RELATIVE/PATH'
    assert_equal '/sources/IDENTIFIER/urls/RELATIVE/PATH', current_path
    within('#user_agents') do
      assert page.has_content?('Most Popular User Agents:')
    end
  end
end


# As a client (this implies you are an existing client/sad path could be non-existing client)
# When I visit: http://yourapplication:port/sources/IDENTIFIER/urls/RELATIVE/PATH
# and that identifier DOES exist
# and that relative AND that  path exist (sad path for these two conditions not being met / separate test)

# xxx Then I should see longest response time
# xxx And I should see shortest response time
# xxxx And I should see average response time
# xxxx And I should see which HTTP verbs have been used
# xxxx And I should see most popular referrers
# xxxx And I should see most popular user agents

# As a client
# When I visit: http://yourapplication:port/sources/IDENTIFIER/urls/RELATIVE/PATH
# and that identifier DOES NOT exists
# Then I should see a message that the url has not been requested