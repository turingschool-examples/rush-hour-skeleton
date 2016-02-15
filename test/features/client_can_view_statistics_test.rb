require_relative '../test_helper'

class ClientCanViewStatisticsTest < FeatureTest
  include TestHelpers

  def test_when_the_client_has_payloads_to_view
    post "/sources", { identifier: "humpstartlab",
                       rootUrl:    "https://humpstartlab.com" }
    post '/sources/humpstartlab/data', { payload: payload.to_json }
    payload_2 = payload(request_type: 'POST')
    post '/sources/humpstartlab/data', { payload: payload_2.to_json }
    post '/sources/humpstartlab/data', { payload: alternate_payload.to_json }

    visit '/sources/humpstartlab'

    assert_equal '/sources/humpstartlab', current_path

    within 'h1' do
      assert page.has_content? 'Humpstartlab Stats'
    end

    assert page.has_content? 'Average Response Time Across All Requests'
    assert page.has_content? '41.67'
    assert page.has_content? 'Max Response Time Across All Requests'
    assert page.has_content? '51.0'
    assert page.has_content? 'Min Response Time Across All Requests'
    assert page.has_content? '37.0'
    assert page.has_content? 'Most Frequent Request Type'
    assert page.has_content? 'GET'

    assert page.has_content? 'HTTP Verbs Used'
    ['GET', 'POST'].each do |verb|
      assert page.has_content? verb
    end

    assert page.has_content? "Most Requested to Least Requested URL's"
    assert page.has_content? '["http://jumpstartlab.com/blog", "http://jumpstartlab.com/about"]'

    assert page.has_content? "Web Browser Breakdown Across All Requests"
    ["Chrome", "Netscape"].each do |browser|
      assert page.has_content? browser
    end

    assert page.has_content? "OS Breakdown Across All Requests"
    ["Mac OS X 10.8.2", "Windows ME"].each do |os|
      assert page.has_content? os
    end

    within('.resolutions') do
      assert page.has_content? "1920x1280"
      assert page.has_content? "1440x900"
    end
  end
end
