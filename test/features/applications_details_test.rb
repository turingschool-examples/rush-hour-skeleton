class ApplicationDetailsTest < Minitest::Test

  def setup
  #As a CLIENT
     indentifier = Identifier.create()
    #visit source_path(identifier) ttp://yourapplication:port/sources/IDENTIFIER
  #And an identifer exists for that client
  end

  def test_it_displays_the_most_visited_urls
  end
  #I should see  a page that displays the most requested URLS to least requested URLS (url)
  #And I should see a web browser breakdown across all requests (userAgent)
  #And I should see a OS breakdown across all requests (userAgent)
  #And I should see a Screen Resolution across all requests (resolutionWidth x resolutionHeight)
  #And I should see a Longest, average response time per URL to shortest, average response time per URL
  #And I should see a Hyperlinks of each url to view url specific data
  #And I should see a Hyperlink to view aggregate event data


  #As a CLIENT
  #When I visit http://yourapplication:port/sources/IDENTIFIER
  #And an identifer does not exist for that client
  #Then I should see the following message ""
end
