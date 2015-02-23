require "./test/test_helper"

class UrlViewsTest < FeatureTest

  def setup
    Source.create({ identifier: "jumpstartlab",
                    root_url: "http://jumpstartlab.com" })
    payload_params = '{"url":"http://jumpstartlab.com/contact","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    PayloadGenerator.call(payload_params, 'jumpstartlab')
    visit "/sources/jumpstartlab/urls/contact"
  end

  def test_user_sees_response_times
      within("#response") do
        assert page.has_content?("Longest")
        assert page.has_content?("Shortest")
        assert page.has_content?("Average")
      end
  end

    def test_user_sees_http_verbs
        within("#verbs") do
          assert page.has_content?("HTTP Request Types")
          assert page.has_content?("GET")
        end
    end

    def test_user_sees_referrer
      within("#referrer") do
        assert page.has_content?("Most popular referrer")
      end
    end

    def test_user_sees_user_agent
        within("#agents") do
          assert page.has_content?("user agents")
        end
    end

end
