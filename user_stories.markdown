As a user
When I submit a POST request to "/sources”
With an “identifier” set to “jumpstartlab”
And a “rootUrl” set to “help://jumpstartlab.com”
Then I should receive a response of 200 OK
And a response body of “{“identifier”:”jumpstartlab”}”

When I submit a POST request to “/sources”
And I am missing an “identifier” and “rootUrl”
Then I should receive response of 400 Bad Request

When I submit a POST request to “/sources”
With an “identifier” and “jumpstartlab”
And the “identifier” has already been taken
Then I should receive response of 403 Forbidden
And I should receive a descriptive error message

when i visit "/sources"
And I click "identifier" button
Then I should be redirected to "/sources/IDENTIFIER"

When I visit "/sources/IDENTIFIER"
Then the page should display "most requested urls: string(requested x times)"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "web browser breakdown: string(viewed x times per browser)"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "OS breakdown: string(viewed x times per OS)"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "screen resolution breakdown: string(viewed x times per resolutionWidth x resolutionHeight)"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "average response time per URL breakdown: string"
Where x is integer

When I visit "/sources/IDENTIFIER"
Then the page should display "hyperlinks of each url to view url specific data

When I visit "/sources/IDENTIFIER"
Then the page should display "hyperlink to view aggregate event data"

When I visit "/sources/IDENTIFIER"
And the identifier does not exist
Then the page should display "identifier does not exist"
