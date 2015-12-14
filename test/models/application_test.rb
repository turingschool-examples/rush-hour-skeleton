require_relative '../test_helper'

class ApplicationTest < Minitest::Test

  def application_data
    {
      identifier: 'jumpstartlab',
      root_url: 'http://jumpstartlab.com'
    }
  end

  def create_application(a)
    Application.create(identifier: a, root_url: "http://#{a}.com")
  end

  def create_requests(app_id, url_id, event_id, num)
    (1..num).to_a.each do |n|
      Request.create(request_data(app_id, url_id, event_id, n))
      Event.create(name: "socialLogin_#{event_id}")
      Url.create(path: "blog_#{url_id}")
    end
  end

  def request_data(app_id, url_id, event_id, n)
    { :request_hash => "582782a967bdfb675f1c3445ded79782ae109f5a#{Random.new_seed}",
      :application_id => app_id,
      :url_id => url_id,
      :timestamp => '2013-02-16 21:38:28 -0700',
      :response_time => 30 + url_id.to_i,
      :referral => 'http://jumpstartlab.com',
      :verb => 'GET',
      :event_id => event_id,
      :browser => "Chrome 24.0.1309#{url_id}",
      :os => "Mac OS X 10.8.2#{url_id}",
      :resolution => "192#{url_id}x128#{event_id}"
      }
  end

  def test_application_is_created_with_valid_attributes
    create_application("jumpstartlab")

    assert_equal "jumpstartlab", Application.last.identifier
    assert_equal "http://jumpstartlab.com", Application.last.root_url
  end

  def test_application_is_not_created_if_duplicate
    create_application("jumpstartlab")

    assert_equal 1, Application.count

    create_application("apple")

    assert_equal 2, Application.count

    create_application("jumpstartlab")

    assert_equal 2, Application.count
  end

  def test_application_has_many_requests
    app = create_application("jumpstartlab")
    create_requests(1, 1, 1, 2)

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

  def test_it_finds_unique_and_sorted_urls
    app = create_application("jumpstartlab")
    create_requests(1, 2, 1, 3)
    create_requests(1, 1, 1, 5)

    expected = [["blog_2", 5],
                ["blog_1", 3]]
    assert_equal expected, app.unique_urls
  end

  def test_it_finds_unique_and_sorted_browsers
    app = create_application("jumpstartlab")
    create_requests(1, 1, 1, 5)
    create_requests(1, 3, 1, 2)

    expected = [["Chrome 24.0.13091", 5],
                ["Chrome 24.0.13093", 2]]
    assert_equal expected, app.unique_browsers
  end

  def test_it_finds_unique_and_sorted_os
    app = create_application("jumpstartlab")
    create_requests(1, 1, 1, 5)
    create_requests(1, 3, 1, 2)

    expected = [["Mac OS X 10.8.21", 5],
                ["Mac OS X 10.8.23", 2]]
    assert_equal expected, app.unique_os
  end

  def test_it_finds_unique_and_sorted_resolutions
    app = create_application("jumpstartlab")
    create_requests(1, 4, 3, 5)
    create_requests(1, 2, 6, 2)

    expected = [["1924x1283", 5],
                ["1922x1286", 2]]
    assert_equal expected, app.unique_resolutions
  end

  def test_it_returns_urls_sorted_by_response_time
    app = create_application("jumpstartlab")
    create_requests(1, 1, 1, 5)
    create_requests(1, 2, 2, 2)

    expected = [["blog_1", 31],
                ["blog_2", 32]]
    assert_equal expected, app.url_by_response_time
  end

  def test_it_prepares_list_of_hyperlinks_to_all_urls
    app = create_application("jumpstartlab")
    create_requests(1, 2, 1, 3)
    create_requests(1, 1, 1, 5)
    expected = ["<a href='/sources/jumpstartlab/urls/blog_1'>/blog_1</a>",
                "<a href='/sources/jumpstartlab/urls/blog_2'>/blog_2</a>"]
    assert_equal expected, app.url_hyperlinks
  end

  def test_it_prepares_hyperlink_to_events_page
    app = create_application("jumpstartlab")
    create_requests(1, 2, 1, 3)
    create_requests(1, 1, 1, 5)

    expected = "<a href='/sources/jumpstartlab/events'>Events Page</a>"
    assert_equal expected, app.events_page_link
  end

  def test_it_prepares_comprehensive_list_of_url_information
    app = create_application("jumpstartlab")
    create_requests(1, 2, 1, 3)
    create_requests(1, 1, 1, 5)

    expected = [  { :name=>"<a href='/sources/jumpstartlab/urls/blog_1'>/blog_1</a>",
                    :frequency=>3,
                    :response_time=>32
                  },
                  { :name=>"<a href='/sources/jumpstartlab/urls/blog_2'>/blog_2</a>",
                    :frequency=>5,
                    :response_time=>31
                  }
                ]
    assert_equal expected, app.comprehensive_url_data
  end
end
