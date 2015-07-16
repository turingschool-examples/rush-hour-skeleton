require './test/test_helper'

class ClientCanViewAggregateSiteDataTest < FeatureTest
  def test_that_an_identifier_does_not_exist
      visit '/sources/jumpstartlab'

      assert page.has_content?("The identifier, jumpstartlab, does not exist."), "Expected message but didn't receive a message"
  end
  def test_that_an_identifier_does_exist
      Site.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
      visit '/sources/jumpstartlab'

      assert page.has_content?("Hello, jumpstartlab"), "Page does not have content jumpstartlab"
  end
end
