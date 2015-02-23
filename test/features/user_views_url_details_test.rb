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


  ###sad path tests
  ### need to be modified to create an instance of client
  ### and then assert that that it directs to error page
  ### if non-existing pages are accessed
  ###change assertion on 'error page' to assert against actual error page

  def test_the_page_rejects_nonexisting_identifier
    skip
    visit 'http://localhost:9393/sources/IDENTIFIER/urls/RELATIVE/PATH'
    refute '/sources/IDENTIFIER/urls/RELATIVE/PATH'
    assert_equal 'error page', current_path
    within('#error') do
      assert page.has_content?('The Identifier you are trying to access Does Not Currently Exist')
    end
  end

  def test_the_page_redirects_to_error_when_missing_relative
    skip
    visit 'http://localhost:9393/sources/IDENTIFIER/urls/RELATIVE/PATH'
    refute '/sources/IDENTIFIER/urls/RELATIVE/PATH'
    assert_equal 'error page', current_path
    within('#error') do
      assert page.has_content?('The Relative You Are Trying To Access Does Not Currently Exist')
    end
  end

  def test_the_page_redirects_to_error_when_missing_path
    skip
    visit 'http://localhost:9393/sources/IDENTIFIER/urls/RELATIVE/PATH'
    refute '/sources/IDENTIFIER/urls/RELATIVE/PATH'
    assert_equal 'error page', current_path
    within('#error') do
      assert page.has_content?('The Path You Are Trying To Access Has Not Been Requested')
    end
  end
end


# xxxx As a client (this implies you are an existing client/sad path could be non-existing client)
# When I visit: http://yourapplication:port/sources/IDENTIFIER/urls/RELATIVE/PATH
# and that identifier DOES exist
# and that relative AND that  path exist (sad path for these two conditions not being met / separate test)

# xxx Then I should see longest response time
# xxx And I should see shortest response time
# xxxx And I should see average response time
# xxxx And I should see which HTTP verbs have been used
# xxxx And I should see most popular referrers
# xxxx And I should see most popular user agents

# xxx As a client
# xxxx When I visit: http://yourapplication:port/sources/IDENTIFIER/urls/RELATIVE/PATH
# xxxx and that identifier DOES NOT exists
# xxxx Then I should see a message that the url has not been requested