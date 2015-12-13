require_relative '../test_helper'

class UserViewsApplicationStatsTest < FeatureTest
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
    { :request_hash => "#{Random.new_seed}",
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

  def test_user_sees_events_link
    create_application('jumpstartlab')
    create_requests(1, 1, 1, 5)
    create_requests(1, 2, 1, 3)

    visit '/sources/jumpstartlab'

    assert page.has_content? 'umpstartlab Stats'
    assert page.has_content? 'Url Stats'

    within("#url_stats") do
      assert page.has_content?('blog_1')
      assert page.has_content?('blog_2')
      refute page.has_content?('blog_3')
      assert page.has_content?('5 times')
      assert page.has_content?('3 times')
      refute page.has_content?('2 times')
      assert page.has_content?('31 seconds')
      assert page.has_content?('32 seconds')
      refute page.has_content?('30 seconds')
    end
  end

  def test_user_sees_list_of_urls_with_links
    create_application('jumpstartlab')
    create_requests(1, 1, 1, 5)
    create_requests(1, 2, 1, 3)

    visit '/sources/jumpstartlab'

    assert page.has_content? 'Url Stats'
    assert page.has_link?('/blog_1', :href => '/sources/jumpstartlab/urls/blog_1')
    assert page.has_link?('/blog_2', :href => '/sources/jumpstartlab/urls/blog_2')
    refute page.has_link?('/blog_3', :href => '/sources/jumpstartlab/urls/blog_3')
  end

  def test_user_sees_list_of_browsers_with_frequency
    create_application('jumpstartlab')
    create_requests(1, 1, 1, 5)
    create_requests(1, 2, 1, 3)

    visit '/sources/jumpstartlab'

    assert page.has_content? 'Browser Popularity'

    within("#browser_popularity") do
      assert page.has_content?("Chrome 24.0.13091")
      assert page.has_content?("Chrome 24.0.13092")
      refute page.has_content?("Chrome 24.0.13093")
      assert page.has_content?("5 times")
      assert page.has_content?("3 times")
      refute page.has_content?("2 times")
    end
  end

  def test_user_sees_list_of_os_with_frequency
    create_application('jumpstartlab')
    create_requests(1, 1, 1, 5)
    create_requests(1, 2, 1, 3)

    visit '/sources/jumpstartlab'

    assert page.has_content? 'Operating System Popularity'

    within("#os_popularity") do
      assert page.has_content?("Mac OS X 10.8.21")
      assert page.has_content?("Mac OS X 10.8.22")
      refute page.has_content?("Mac OS X 10.8.24")
      assert page.has_content?("5 times")
      assert page.has_content?("3 times")
      refute page.has_content?("2 times")
    end
  end

  def test_user_sees_list_of_resolutions_with_frequency
    create_application('jumpstartlab')
    create_requests(1, 1, 1, 5)
    create_requests(1, 2, 1, 3)

    visit '/sources/jumpstartlab'

    assert page.has_content? 'Resolution Popularity'

    within("#resolution_popularity") do
      assert page.has_content?("1921x1281")
      assert page.has_content?("1922x1281")
      refute page.has_content?("1921x1284")
      assert page.has_content?("5 times")
      assert page.has_content?("3 times")
      refute page.has_content?("2 times")
    end
  end

  def test_user_sees_error_message_if_accessing_unregistered_url
    visit '/sources/jumpstartlab'

    assert page.has_content? "This application has not been registered"
  end

  def test_user_sees_error_message_if_no_requests_have_been_documented
    create_application('jumpstartlab')

    visit '/sources/jumpstartlab'

    assert page.has_content? "This application has no documented requests"
  end
end
