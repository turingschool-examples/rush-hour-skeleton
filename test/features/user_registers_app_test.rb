require_relative '../test_helper'

class UserRegistersApp < FeatureTest
  #
  # def test_successfully
  #   # As a new or non-logged-in user
  #     # Question - How do you identify whether a user is new or already logged in?
  #   # When I visit the home page
  #   visit '/'
  #   # And I click on the register button
  #   click_button('Register')
  #   assert_equal '/sources', current_path
  #   # And I fill in a name for the identifier and my root url
  #   fill_in('app[identifier]', with: 'jumpstartlab')
  #   fill_in('app[rootUrl]', with: 'http://jumpstartlab.com')
  #   # And I click a submit button
  #   click_button('Submit') #post request
  #   # I should see message that tells me that my app is registered
  #   within("#registered") do
  #     assert page.has_content? 'Your website is now registered for web traffic tracking!'
  #   end
  # end
  #
  # def test_with_missing_parameters
  # skip
  #   # As a new or non-logged-in user
  #   # When I visit the home page
  #   visit '/'
  #   # And I click on the register button
  #   click_button('Register')
  #   assert_equal '/sources', current_path
  #   # And I fill in a name for the identifier and my root url
  #   fill_in('app[identifier]', with: 'jumpstartlab')
  #   fill_in('app[rootUrl]', with: 'http://jumpstartlab.com')
  #   # And I click a submit button
  #   click_button('Submit')
  #   # I should see an error message that tells me that I didn't fill in all the parameters
  #   within("#registered") do
  #     assert page.has_content? 'Oops, looks like you forgot to fill in all of your information. Please try again.'
  #   end
  # end
  #
  # def test_with_an_existing_identifier
  #   skip
  #   # As a new or non-logged-in user
  #   # When I visit the home page
  #   visit '/'
  #   # And I click on the register button
  #   click_button('Register')
  #   assert_equal '/sources', current_path
  #   # And I fill in a name for the identifier and my root url
  #   fill_in('app[identifier]', with: 'jumpstartlab')
  #   fill_in('app[rootUrl]', with: 'http://jumpstartlab.com')
  #   # And I click a submit button
  #   click_button('Submit')
  #   # Or I should see a page that tells me that my identifier already exists
  #   within("#registered") do
  #     assert page.has_content? 'This identifier already exists. Please try a new indentifier.'
  #   end
  # end
end
