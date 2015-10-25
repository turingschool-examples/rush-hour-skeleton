require_relative '../test_helper'

class ApplicationDetails < FeatureTest
  def test_a_user_can_view_application_details
    post '/sources', {identifier: "jumpstartlab",
                      rootUrl: "http://jumpstartlab.com"
                     }

    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog",
                                                 "requestedAt":"2013-02-16 21:38:28 -0700",
                                                 "respondedIn":37,"referredBy":"http://jumpstartlab.com",
                                                 "requestType":"GET",
                                                 "parameters":[],
                                                 "eventName": "socialLogin",
                                                 "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                                 "resolutionWidth":"1920",
                                                 "resolutionHeight":"1280",
                                                 "ip":"63.29.38.211"}'

    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/about",
                                                 "requestedAt":"2013-02-16 21:38:28 -0700",
                                                 "respondedIn":37,"referredBy":"http://jumpstartlab.com",
                                                 "requestType":"GET",
                                                 "parameters":[],
                                                 "eventName": "socialLogin",
                                                 "userAgent":"Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/24.0.1309.0 Safari/537.17",
                                                 "resolutionWidth":"1920",
                                                 "resolutionHeight":"1280",
                                                 "ip":"63.29.38.211"}'
    visit '/sources/jumpstartlab'
    visit '/sources/jumpstartlab/urls/blog'
    assert page.has_content?('Url Statistics')
    assert page.has_content?('37')
    assert page.has_content?('Shortest Response Time')
    assert page.has_content?('37')
    assert page.has_content?('Average Response Time')
    assert page.has_content?('Verb Usage')
    assert page.has_content?('Verb')
    assert page.has_content?('GET')
    assert page.has_content?('Count')
    assert page.has_content?('1')
    assert page.has_content?('Most Popular Referrers')
    assert page.has_content?('Referrer')
    assert page.has_content?('http://jumpstartlab.com')
    assert page.has_content?('Count')
    assert page.has_content?('1')
    assert page.has_content?('Most Popual User Agents')
    assert page.has_content?('Agent')
    assert page.has_content?('Macintosh')
    assert page.has_content?('Count')
    assert page.has_content?('1')
  end
end
