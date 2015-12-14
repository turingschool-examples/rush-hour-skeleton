require_relative '../test_helper.rb'
class UserViewsAggregateEventsData < FeatureTest
  def test_user_views_aggregate_events_data
    Application.create(identifier: 'jumpstartlab', root_url: "home")
    Event.create(name: 'socialLogin')
    Event.create(name: 'delete')
    Request.create( application_id: 1, request_hash: '1', event_id: 1)
    Request.create( application_id: 1, request_hash: '2', event_id: 2)
    Request.create( application_id: 1, request_hash: '3', event_id: 2)

    visit '/sources/jumpstartlab/events'

    within ('#socialLogin') do
      assert page.has_content?('socialLogin')
      assert page.has_content?('1')
    end

    within ('#delete') do
      assert page.has_content?('delete')
      assert page.has_content?('2')
    end
  end

  def test_user_vies_error_message_if_no_events
    Application.create(identifier: 'jumpstartlab', root_url: "home")

    visit '/sources/jumpstartlab/events'

    assert page.has_content?('No events have been defined')
  end
end
