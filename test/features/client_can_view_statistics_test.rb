require_relative '../test_helper'

class ClientCanViewStatisticsTest < Minitest::Test
  include TestHelpers
  include Rack::Test::Methods
  include Capybara::DSL

  def test_when_the_client_has_payloads_to_view
    post "/sources", { identifier: "humpstartlab",
                       rootUrl:    "https://humpstartlab.com" }
    post '/sources/humpstartlab/data', { payload: payload.to_json }
    post '/sources/humpstartlab/data', { payload: alternate_payload.to_json }

    visit '/sources/humpstartlab'

    assert_equal '/sources/humpstartlab', current_path

    within 'h1' do
      assert page.has_content? 'Humpstartlab Stats'
    end

    assert page.has_content? 'Average Response Time Across All Requests'
    assert page.has_content? '44.0'
    assert page.has_content? 'Max Response Time Across All Requests'
    assert page.has_content? '51.0'
    assert page.has_content? 'Min Response Time Across All Requests'
    assert page.has_content? '37.0'
  end
end
