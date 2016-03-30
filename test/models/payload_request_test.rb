require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_payload_request
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    request = PayloadRequest.all.first

    assert_equal 1, request.url_id
    assert_equal "2013-02-16 21:38:28 -0700".to_date, request.requested_at
    assert_equal 1, request.response_time
    assert_equal 1, request.referral_id
    assert_equal 1, request.request_type_id
    assert_equal 1, request.     event_id
    assert_equal 1, request.user_agent_id
    assert_equal 1, request.resolution_id
    assert_equal 1, request.ip_id
  end

  def test_it_doesnt_save_a_payload_request_without_a_valid_url_id
    PayloadRequest.create(
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal [], PayloadRequest.all.to_a
  end

  def test_it_doesnt_save_a_payload_request_without_a_valid_requested_at_timestamp
    PayloadRequest.create(url_id: 1,
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal [], PayloadRequest.all.to_a
  end

  def test_it_doesnt_save_a_payload_request_without_a_valid_response_time_id
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal [], PayloadRequest.all.to_a
  end

  def test_it_doesnt_save_a_payload_request_without_a_valid_referral_id
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal [], PayloadRequest.all.to_a
  end

  def test_it_doesnt_save_a_payload_request_without_a_valid_request_type_id
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal [], PayloadRequest.all.to_a
  end

  def test_it_doesnt_save_a_payload_request_without_a_valid_event_id
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal [], PayloadRequest.all.to_a
  end

  def test_it_doesnt_save_a_payload_request_without_a_valid_user_agent_id
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal [], PayloadRequest.all.to_a
  end

  def test_it_doesnt_save_a_payload_request_without_a_valid_resolution_id
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                           ip_id: 1)

    assert_equal [], PayloadRequest.all.to_a
  end

  def test_it_doesnt_save_a_payload_request_without_a_valid_ip_id
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1)

    assert_equal [], PayloadRequest.all.to_a
  end

  def test_it_can_return_average_response_time_across_all_requests
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

   PayloadRequest.create(url_id: 1,
                   requested_at: "2013-02-16 21:38:28 -0700",
                  response_time: 300,
                    referral_id: 1,
                request_type_id: 1,
                       event_id: 1,
                  user_agent_id: 1,
                  resolution_id: 1,
                          ip_id: 1)

    assert_equal 200, PayloadRequest.average_response_time
  end

  def test_it_can_return_max_response_time_across_all_requests
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

   PayloadRequest.create(url_id: 1,
                   requested_at: "2013-02-16 21:38:28 -0700",
                  response_time: 300,
                    referral_id: 1,
                request_type_id: 1,
                       event_id: 1,
                  user_agent_id: 1,
                  resolution_id: 1,
                          ip_id: 1)

    assert_equal 300, PayloadRequest.max_response_time
  end

  def test_it_can_return_min_response_time_across_all_requests
    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

   PayloadRequest.create(url_id: 1,
                   requested_at: "2013-02-16 21:38:28 -0700",
                  response_time: 300,
                    referral_id: 1,
                request_type_id: 1,
                       event_id: 1,
                  user_agent_id: 1,
                  resolution_id: 1,
                          ip_id: 1)

    assert_equal 100, PayloadRequest.min_response_time
  end

  # def test_it_returns_url_with_max_response_time
  #   url1 = Url.create(root_url: "www.jumpstartlabs.com",
  #                         path: "/blog")
  #   url2 = Url.create(root_url: "www.jumpstartlabs.com",
  #                         path: "/example")
  #
  #   PayloadRequest.create(url_id: url1.id,
  #                   requested_at: "2013-02-16 21:38:28 -0700",
  #                  response_time: 100,
  #                    referral_id: 1,
  #                request_type_id: 1,
  #                  event_id: 1,
  #                  user_agent_id: 1,
  #                  resolution_id: 1,
  #                          ip_id: 1)
  #   PayloadRequest.create(url_id: url2.id,
  #                   requested_at: "2013-02-16 21:38:28 -0700",
  #                  response_time: 300,
  #                    referral_id: 1,
  #                request_type_id: 1,
  #                  event_id: 1,
  #                  user_agent_id: 1,
  #                  resolution_id: 1,
  #                          ip_id: 1)
  #
  #   assert_equal "www.jumpstartlabs.com/example", PayloadRequest.url_with_max_response_time
  # end
  #
  # def test_it_returns_url_with_max_response_time
  #   url1 = Url.create(root_url: "www.jumpstartlabs.com",
  #                         path: "/blog")
  #   url2 = Url.create(root_url: "www.jumpstartlabs.com",
  #                         path: "/example")
  #
  #   PayloadRequest.create(url_id: url1.id,
  #                   requested_at: "2013-02-16 21:38:28 -0700",
  #                  response_time: 100,
  #                    referral_id: 1,
  #                request_type_id: 1,
  #                  event_id: 1,
  #                  user_agent_id: 1,
  #                  resolution_id: 1,
  #                          ip_id: 1)
  #   PayloadRequest.create(url_id: url2.id,
  #                   requested_at: "2013-02-16 21:38:28 -0700",
  #                  response_time: 300,
  #                    referral_id: 1,
  #                request_type_id: 1,
  #                  event_id: 1,
  #                  user_agent_id: 1,
  #                  resolution_id: 1,
  #                          ip_id: 1)
  #
  #   assert_equal "www.jumpstartlabs.com/blog", PayloadRequest.url_with_min_response_time
  # end
end
