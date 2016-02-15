require_relative '../test_helper'

class ClientReceivesErrorPageIfIdentifierDoesNotExistTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_displays_message_that_the_identifier_does_not_exist
    visit '/sources/hopstartlabs'

    assert_equal '/sources/hopstartlabs', current_path

    save_and_open_page

    within('h1') do
      assert page.has_content? "Oh no! There seems to be an error!"
    end

    within('h2') do
      assert page.has_content? "Identifier does not exist"
    end
  end
end
