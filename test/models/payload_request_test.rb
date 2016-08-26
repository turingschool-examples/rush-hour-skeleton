require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def create_payload
    # NOTE: The payload below has the column types reformatted already
    payload = '{
      "url":"http://jumpstartlab.com/blog",
      "requested_at":"2013-02-16 21:38:28 -0700",
      "responded_in":37,
      "referred_by":"http://jumpstartlab.com",
      "request_type":"GET",
      "u_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolution_width":"1920",
      "resolution_height":"1280",
      "ip":"63.29.38.211"
    }'
  end

  def test_it_validates_for_all_fields
    # parsed_payload = JSON.parse(create_payload)
    payload = { url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2
            }

    # refute PayloadRequest.new(url_id: 1).valid?
    assert PayloadRequest.create(payload).valid?
  end

  def test_it_fails_if_not_all_field_filled
    payload = {url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6
            }

    refute PayloadRequest.create(payload).valid?
  end

  def test_it_returns_average_response_time_across_all_payloads
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 36,
              referred_by_id: 1,
              request_type_id: 2,
              u_agent_id: 3,
              resolution_id: 6,
              ip_id: 2
            })

    assert_equal 35, PayloadRequest.average_response_time
    assert_equal 2, PayloadRequest.all.count
  end
end
