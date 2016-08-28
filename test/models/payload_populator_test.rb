require_relative '../test_helper'
require './app/models/payload_populator'

class PayloadPopulatorTest < ModelTest

  def test_it_populates_the_database
    Client.create({'identifier'=>'jumpstartlab', 'root_url'=>'http://jumpstartlab.com'})
    payload = {
      url: "http://jumpstartlab.com/blog",
      requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 37,
      referred_by: "http://jumpstartlab.com",
      request_type: "GET",
      browser: "Chrome",
      operating_system: "OS X 10.8.2",
      resolution_width: "1920",
      resolution_height: "1280",
      ip: "63.29.38.211"
      }
    populated = PayloadPopulator.populate(payload, "jumpstartlab")
    assert populated.save
    assert_equal 1, PayloadRequest.all.count
  end

end
