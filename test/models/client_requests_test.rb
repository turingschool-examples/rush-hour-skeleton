class ClientRequestTest < ModelTest
  def test_it_can_get_all_request_types_for_a_specific_client
    client1 = Client.create({identifier: "jumpstartlab", root_url: "http://www.jumpstartlab.com"})
    client2 = Client.create({identifier: "google", root_url: "http://www.google.com"})

    request_type1 = RequestType.create({http_verb: "GET"})
    request_type2 = RequestType.create({http_verb: "PUSH"})

    PayloadRequest.create({ requested_at: '2016-08-23',
                            responded_in: 4,
                            resolution_id: 2,
                            system_information_id: 2,
                            referral_id: 3,
                            ip_id: 4,
                            request_type_id: request_type1.id,
                            url_id: 3,
                            client_id: client1.id
    })

    PayloadRequest.create({ requested_at: '2016-08-23',
      responded_in: 5,
      resolution_id: 2,
      system_information_id: 2,
      referral_id: 3,
      ip_id: 4,
      request_type_id: request_type2.id,
      url_id: 2,
      client_id: client2.id
      })

    request_types = client1.request_types
    request_types.list_all_verbs

    assert_equal ["GET"], request_types.list_all_verbs
  end
end
