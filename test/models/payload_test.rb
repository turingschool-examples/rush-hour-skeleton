require_relative '../test_helper'

class PayloadTest < Minitest::Test
  include TestHelpers

  def setup
    @payload = {
      requested_at: "2013-02-16 21:38:28 -0700",
      response_time: 37,
      parameters: ["sushi"],
      event_id: Event.create(name: "socialLogin").id,
      ip_id: Ip.create(address: "63.29.38.211").id,
      refer_id: Refer.create(address: "http://jumpstartlab.com").id,
      resolution_id: Resolution.create(width: "1920", height: "1280").id,
      url_id: Url.create(address: "http://jumpstartlab.com/blog").id,
      user_environment_id: UserEnvironment.create(browser: "Chrome", os: "SOS").id,
      request_type_id: RequestType.create(verb: "GET").id
    }
  end

  def test_responds_to_other_methods
    e = Payload.create(@payload)
    attributes = [:id, :requested_at, :response_time, :parameters, :event, :ip, :refer, :resolution, :url, :user_environment, :request_type]

    attributes.each do |attribute|
      assert e.respond_to? attribute
    end
    assert e.id
    assert e.parameters
  end

  def test_brings_in_correct_data
    e = Payload.create(@payload)

    assert_equal "63.29.38.211", e.ip.address
  end

  def test_wont_validate_incorrect_data
    e = Payload.create
    assert_nil e.id

    d = Payload.new ip: nil
    assert_nil d.ip
  end

  def test_average_response_time_returns_correct_value
    setup_1
    assert_equal 30, Payload.average_response_time
  end

  def test_min_response_returns_single_correct_value
    setup_1
    assert_equal 20, Payload.min_response_time
  end

  def test_max_response_returns_single_correct_value
    setup_1
    assert_equal 40, Payload.max_response_time
  end

  def test_return_most_frequent_request_type
    skip
    setup_1
    assert_equal "GET", Payload.most_frequent_request_type
  end

  def test_returns_list_of_all_verbs_used_ever
    skip
    setup_1
    assert_equal "GET", "POST" , Payload.method
  end

  def test_returns_max_response_time_for_given_url
    client_url = "http://jumpstartlab.com"
    setup_1
    time = Payload.max_response_time_given_url(client_url)
    assert_equal 30, time
  end

end
