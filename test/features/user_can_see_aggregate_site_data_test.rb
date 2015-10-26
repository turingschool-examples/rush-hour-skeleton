require './test/test_helper'

module TrafficSpy
  class AggregateDataTest < FeatureTest
    def test_a_user_can_view_the_aggregate
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
      authorize_admin
      visit '/sources/jumpstartlab'

      assert page.has_content?("http://jumpstartlab.com/blog")
      assert page.has_content?("http://jumpstartlab.com/about")
      assert page.has_content?("Macintosh")
      assert page.has_content?("Windows")
      assert page.has_content?("Chrome")
      assert page.has_content?("Opera")
    end
  end
end
