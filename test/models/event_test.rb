require_relative '../test_helper'

class EventTest < Minitest::Test

  def create_application(a)
    Application.create(identifier: a, root_url: "http://#{a}.com")
  end

  def create_requests(app_id, event_id, timestamp, num)
    (1..num).to_a.each do |n|
      Request.create(request_data(app_id, event_id, timestamp, n))
      Event.create(name: "socialLogin_#{event_id}")
    end
  end

  def request_data(app_id, event_id, timestamp, n)
    { :request_hash => "582782a967bdfb675f1c3445ded79782ae109f5a#{Random.new_seed}",
      :application_id => app_id,
      :timestamp => "2013-02-16 #{timestamp}:38:28 -0700",
      :event_id => event_id,
      }
  end

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

    assert_equal 0, Event.count
  end

  def test_is_not_created_with_duplicated_name
    Event.create(event_data)
    Event.create(event_data)

    assert_equal 1, Event.count
  end

  def test_has_many_requests
    event = Event.create(event_data)

    Request.create(event_id: 1,request_hash: Digest::SHA1.hexdigest("1"))
    Request.create(event_id: 1,request_hash: Digest::SHA1.hexdigest("2"))

    assert_equal 2, event.requests.count
  end

  def test_it_finds_request_data_matching_app_id_and_event
    app_1 = create_application("jumpstartlab")
    app_2 = create_application("apple")
    create_requests(1, 1, 15, 3)
    create_requests(1, 4, 12, 2)
    create_requests(1, 1, 23, 5)
    create_requests(1, 1, 12, 2)
    create_requests(2, 1, 12, 2)

    event = Event.find_by(name: "socialLogin_1")

    assert_equal 10, event.requests_for_given_app(app_1.id).count
  end

  def test_it_extracts_hours_for_given_requests
    app_1 = create_application("jumpstartlab")
    create_requests(1, 1, 15, 3)
    create_requests(1, 1, 23, 5)
    create_requests(1, 1, 12, 2)
    event = Event.find_by(name: "socialLogin_1")

    expected = [22, 22, 22, 6, 6, 6, 6, 6, 19, 19]
    assert_equal expected, event.array_of_hours(app_1.id)
  end


  def test_it_sorts_frequency_of_all_hours
    app_1 = create_application("jumpstartlab")
    create_requests(1, 1, 15, 3)
    create_requests(1, 1, 23, 5)
    create_requests(1, 1, 12, 2)
    event = Event.find_by(name: "socialLogin_1")

    expected = [{0=>0}, {1=>0}, {2=>0}, {3=>0},
                {4=>0}, {5=>0}, {6=>5}, {7=>0},
                {8=>0}, {9=>0}, {10=>0}, {11=>0}, 
                {12=>0}, {13=>0}, {14=>0}, {15=>0},
                {16=>0}, {17=>0}, {18=>0}, {19=>2},
                {20=>0}, {21=>0}, {22=>3}, {23=>0}]
    assert_equal expected, event.sorted_list_by_hour(app_1.id)
  end
end