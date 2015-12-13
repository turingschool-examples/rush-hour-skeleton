require_relative '../test_helper'

class ApplicationTest < Minitest::Test

  def application_data
    {
      identifier: 'jumpstartlab',
      root_url:   'http://jumpstartlab.com'
    }
  end

  def test_application_is_created_with_valid_attributes
    Application.create(application_data)
    assert_equal "jumpstartlab", Application.last.identifier
    assert_equal "http://jumpstartlab.com", Application.last.root_url
  end

  def test_application_has_many_requests
    app = Application.create(application_data)
    Request.create(application_id: 1,request_hash: Digest::SHA1.hexdigest("1"))
    Request.create(application_id: 1,request_hash: Digest::SHA1.hexdigest("2"))

    assert_equal 2, app.requests.count
  end

  def test_model_calculations
    app = Application.create(application_data)
    Event.create(name: 'socialLogin')
    Event.create(name: 'delete')
    Event.create(name: 'win')
    Request.create( application_id: 1, request_hash: '1', event_id: 1)
    Request.create( application_id: 1, request_hash: '2', event_id: 2)
    Request.create( application_id: 1, request_hash: '3', event_id: 3)
    Request.create( application_id: 1, request_hash: '4', event_id: 1)
    Request.create( application_id: 1, request_hash: '5', event_id: 3)
    Request.create( application_id: 1, request_hash: '6', event_id: 3)

    assert_equal [["win", 3], ["socialLogin", 2], ["delete", 1]], app.unique_events
    assert_equal 3, app.ordered_events[0][1]
    assert_equal 'win', app.ordered_events[0][0].name
    assert_equal 2, app.ordered_events[1][1]
    assert_equal 'socialLogin', app.ordered_events[1][0].name
    assert_equal 1, app.ordered_events[2][1]
    assert_equal 'delete', app.ordered_events[2][0].name
  end
end
