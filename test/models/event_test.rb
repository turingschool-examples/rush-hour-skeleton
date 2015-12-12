require_relative '../test_helper'

class EventTest < Minitest::Test

  def event_data
    {
      name: 'socialLogin'
    }
  end

  def test_is_created_with_valid_attributes
    Event.create(event_data)
    assert_equal 'socialLogin', Event.last.name
  end

  def test_is_not_created_without_name
    Event.create(name: nil)

    assert_equal 0, Event.all.count
  end

  def test_is_not_created_with_duplicated_name
    Event.create(event_data)
    Event.create(event_data)

    assert_equal 1, Event.all.count
  end

  def test_has_many_requests
    event = Event.create(event_data)

    Request.create(event_id: 1,request_hash: Digest::SHA1.hexdigest("1"))
    Request.create(event_id: 1,request_hash: Digest::SHA1.hexdigest("2"))

    assert_equal 2, event.requests.count
  end

  # create migration $ rake db:create_migration NAME=create_films
  # write migration file
  # migrate
  # check schema
  # create model file (inherits from ActiveRecord::Base)
  # write model file

  # write migration to add column
  # ran the migration
  # bd:test:prepare
  # delete_all from all models
  # run test_loader

  # update model tests
  # add method to parser to prepare event_id in the request_data DONE

end
