require_relative '../test_helper'

class PayloadAnalystTest < Minitest::Test
  def setup
    @payload1 = {
      requested_at: "2013-02-16 22:38:28 -0700",
      response_time: 20,
      parameters: [],
      event_id: Event.create(name: "socialLogin").id,
      ip_id: Ip.create(address: "63.29.38.211").id,
      refer_id: Refer.create(address: "http://google.com").id,
      resolution_id: Resolution.create(width: "1000", height: "1000").id,
      url_id: Url.create(address: "http://jumpstartlab.com/blog").id,
      user_environment_id: UserEnvironment.create(browser: "Mozilla", os: "windows").id,
      request_type_id: RequestType.create(verb: "POST").id
    }

    @payload2 = {
      requested_at: "2013-02-16 21:38:28 -0700",
      response_time: 30,
      parameters: [],
      event_id: Event.create(name: "differentEvent").id,
      ip_id: Ip.create(address: "63.29.38.211").id,
      refer_id: Refer.create(address: "http://turing.io").id,
      resolution_id: Resolution.create(width: "2000", height: "2000").id,
      url_id: Url.create(address: "http://jumpstartlab.com").id,
      user_environment_id: UserEnvironment.create(browser: "Safari", os: "doors").id,
      request_type_id: RequestType.create(verb: "GET").id
    }
    @payload3 = {
      requested_at: "2013-02-16 22:38:28 -0700",
      response_time: 40,
      parameters: [],
      event_id: Event.create(name: "socialLogin").id,
      ip_id: Ip.create(address: "62.29.38.211").id,
      refer_id: Refer.create(address: "http://jumpstartlab.com").id,
      resolution_id: Resolution.create(width: "500", height: "500").id,
      url_id: Url.create(address: "http://jumpstartlab.com/jumps").id,
      user_environment_id: UserEnvironment.create(browser: "Chrome", os: "SOS").id,
      request_type_id: RequestType.create(verb: "GET").id
    }

    @payload_analyst = PayloadAnalyst.new
  end

  def test_payload_analyst_exists
    assert_kind_of PayloadAnalyst, @payload_analyst
  end

  def test_analyst_chooses_correct_database_for_environment
    db = @payload_analyst.database
    assert_equal "rush-hour-test"
  end
end
