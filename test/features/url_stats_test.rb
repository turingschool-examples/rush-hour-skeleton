require "./test/test_helper"

class EventIndexTest < FeatureTest

  def setup
    register_user_and_create_payload
  end

  def test_user_sees_response_times
    visit "/sources/jumpstartlab/urls/contact"
      within("#response") do
        assert page.has_content?("Longest")
        assert page.has_content?("Average")
      end
  end

    def test_user_sees_http_verbs
      visit "/sources/jumpstartlab/urls/contact"
        within("#verbs") do
          assert page.has_content?("GET")
        end
    end

    def test_user_sees_user_agent
      visit "/sources/jumpstartlab/urls/contact"
        within("#agents") do
          assert page.has_content?("user agents")
          # assert page.has_content?("Chrome")
        end
    end

end
