require './test/test_helper'

class UserCanViewIndexOfAllEvents < FeatureTest
  def test_user_can_view_list_of_all_events_grouped_by_count
    register_turing_and_send_multiple_payloads
    
    visit '/sources/turing/events'

    within 'ol li:nth-child(1)' do
      assert page.has_content?('socialLoginB')
      assert page.has_css?("a[href~='/sources/turing/events/socialLoginB']")
    end

    within 'ol li:nth-child(2)' do
      assert page.has_content?('socialLoginA')
      assert page.has_css?("a[href~='/sources/turing/events/socialLoginA']")
    end

    within 'ol li:nth-child(3)' do
      assert page.has_content?('socialLoginC')
      assert page.has_css?("a[href~='/sources/turing/events/socialLoginC']")
    end
  end
end
