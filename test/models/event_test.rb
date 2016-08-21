require_relative "../test_helper"

class EventTest < Minitest::Test
  include TestHelpers

  def setup
    Event.create({name: "socialLogin"})
    Event.create({name: "antisocialLogin"})

    PayloadRequest.create({
                          :url_id=> "1",
                          :requested_at=> "2015-02-06",
                          :responded_in=> 50,
                          :referrer_id=> "http://jumpstartlab.com",
                          :request_id=> "GET",
                          :parameters=> [],
                          :event_id=> 1,
                          :user_agent_b_id=> "1",
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })

    PayloadRequest.create({
                          :url_id=> "1",
                          :requested_at=> "2015-06-06",
                          :responded_in=> 100,
                          :referrer_id=> "http://jumpstartlab.com",
                          :request_id=> "GET",
                          :parameters=> [],
                          :event_id=> 2,
                          :user_agent_b_id=> "1",
                          :resolution_id=> "2",
                          :ip_id=> "63.19.32.211"
                          })
  end

  def test_event_most_received_to_least
    client = #make client
    #client.events.create()... give client events
    #give events a bunch of payload requests
    #assert_equal , client.events.event_most_recieved_to_least(client)

    event = Event.find(1)
    event.event_most_recieved_to_least
  end

end
