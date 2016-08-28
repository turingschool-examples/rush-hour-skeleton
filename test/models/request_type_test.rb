require_relative '../test_helper'
require './app/models/request_type'

class RequestTypeTest < ModelTest
  def test_it_validates_input
    request_type = RequestType.new({http_verb: "GET"})

    request_type_sad = RequestType.new({})
    assert request_type.save
    refute request_type_sad.save
  end

  def test_it_has_unique_requests
    request_type = RequestType.create({http_verb: "GET"})
    request_type = RequestType.new({http_verb: "GET"})

    refute request_type.save
  end

  def test_it_can_return_all_verbs_used
    request_type = RequestType.create({http_verb: "PUSH"})
    PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 5,
                            resolution_id: 2,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: request_type.id,
                            url_id: 2,
                            client_id: 3
    })

    assert_equal ["PUSH"], RequestType.list_all_verbs
  end

  def test_it_returns_most_frequent_request
    request_type1 = RequestType.create({http_verb: "GET"})
    request_type2 = RequestType.create({http_verb: "PUSH"})
    request_type3 = RequestType.create({http_verb: "DELETE"})
    PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 5,
                            resolution_id: 2,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: request_type2.id,
                            url_id: 2,
                            client_id: 3
                            })

    PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 4,
                            resolution_id: 2,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: request_type1.id,
                            url_id: 3,
                            client_id: 3
    })
    expected = {"GET" => 1, "PUSH" => 1}
    assert_equal expected, RequestType.most_frequent_request
  end
end
