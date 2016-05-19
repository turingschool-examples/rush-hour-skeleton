require_relative "../test_helper"

class ValidatePayloadRequestTest < Minitest::Test
    include TestHelpers

  def setup
    PayloadRequest.create({
                          :id_url=> "http://jumpstartlab.com/blog",
                          :requested_at=> "2015-02-20",
                          :responded_in=> 37,
                          :id_referrer=> "http://jumpstartlab.com",
                          :id_request=> "GET",
                          :parameters=> [],
                          :id_event=> "socialLogin",
                          :id_useragent=> "1",
                          :id_resolution=> "1",
                          :id_ip=> "63.29.38.211"
                          })

    PayloadRequest.create({
                          :id_url=> "http://www.google.com",
                          :requested_at=> ".",
                          :responded_in=> 100,
                          :id_referrer=> "http://jumpstartlab.com",
                          :id_request=> "GET",
                          :parameters=> [],
                          :id_event=> "antisocialLogin",
                          :id_useragent=> "1",
                          :id_resolution=> "2",
                          :id_ip=> "63.19.32.211"
                          })
  end

  # def test_it_validates_new_payload_request_with_all_fields
  #   assert @payload.valid?
  # end
  #
  # def test_it_validates_new_payload_request_with_missing_fields
  #   refute @payload2.valid?
  # end
  #
  # def test_it_takes_in_url
  #   assert_equal "http://jumpstartlab.com/blog", @payload.id_url
  # end

  def test_average_response_time
    time = PayloadRequest.all.average_response_time

    assert_equal 68, time
  end

end
