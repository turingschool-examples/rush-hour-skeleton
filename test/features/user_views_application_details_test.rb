
class UserViewsApplicationDetails < FeatureTest

end
# As a client
# When I visit http://yourapplication:port/sources/IDENTIFIER
# And that  identifer exists
# Then I should see a page that displays the most requested URLS to least requested URLS (url)
# And I should see a web browser breakdown across all requests (userAgent)
# And I should see an OS breakdown across all requests (userAgent)
# And I should see Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
# And I should see a Longest, average response time per URL to shortest, average response time per URL
# And I should see a Hyperlinks of each url to view url specific data
# And I should see a Hyperlink to view aggregate event data
#
# As a client
# When I visit http://yourapplication:port/sources/IDENTIFIER
# And the identifier does not exist
# Then I should see a "Some notification message"
