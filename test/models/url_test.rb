require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_url
    Url.create(root_url: "www.jumpstartlabs.com",
                   path: "/example")

    url = Url.first

    assert_equal "www.jumpstartlabs.com", url.root_url
    assert_equal "/example", url.path
  end

  def test_it_doesnt_save_url_with_invalid_path
    Url.create(root_url: "www.jumpstartlabs.com")

    assert_equal [], Url.all.to_a
  end

  def test_it_doesnt_save_url_with_invalid_root_url
    Url.create(path: "/example")

    assert_equal [], Url.all.to_a
  end

  def test_it_returns_the_full_path_url
    url = Url.create(root_url: "www.jumpstartlabs.com",
                   path: "/example")

    assert_equal "www.jumpstartlabs.com/example", url.full_path
  end

  def test_it_returns_most_to_least_requested_urls
    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")
    url2 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/example")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                response_time_id: 1,
                     referral_id: 1,
                 request_type_id: 1,
                   event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)
    PayloadRequest.create(url_id: url2.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                response_time_id: 1,
                     referral_id: 1,
                 request_type_id: 1,
                   event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)
    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                response_time_id: 1,
                     referral_id: 1,
                 request_type_id: 1,
                   event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal ["www.jumpstartlabs.com/blog", "www.jumpstartlabs.com/example"], Url.most_to_least_requested
  end

end
