require_relative '../test_helper'

class ClientRecievesErrorMessageIfNoPayloadsTest < Minitest::Test
  include TestHelpers
  include Rack::Test::Methods
  include Capybara::DSL

  def test_displays_message_that_the_client_has_no_payloads
    post "/sources", { identifier: "jumpstartlab",
                       rootUrl:    "https://jumpstartlab.com" }

    visit '/sources/jumpstartlab'

    assert_equal '/sources/jumpstartlab', current_path

    save_and_open_page

    within('h1') do
      assert page.has_content? 'Oh no! There seems to be an error!'
    end

    within('h2') do
      assert page.has_content? 'No payload data has been received for this source.'
    end
  end
end
