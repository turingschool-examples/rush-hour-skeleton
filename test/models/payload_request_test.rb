require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test

  def setup
    @payload = PayloadRequest.new
  end

  # def test_full_payload_request_is_valid
  #   payload = PayloadRequest.create({
  #     "url"=> "http://jumpstartlab.com/blog",
  #     "requested_at" => "2013-02-16 21:38:28 -0700",
  #     "responded_in"=>37,
  #     "reference"=>"http://jumpstartlab.com",
  #     "request_type"=>"GET",
  #     "parameters"=>[],
  #     "event_name"=> "socialLogin",
  #     "user_agent"=>"Mozilla/5.0 ",
  #     "resolution_width"=>"1920",
  #     "resolution_height"=>"1280",
  #     "ip"=>"63.29.38.211"
  #   })
  #
  #   assert payload.valid?
  # end
  #
  # def test_missing_line_payload_request_is_invalid
  #   payload = PayloadRequest.create({
  #     "url"=> "http://jumpstartlab.com/blog",
  #     "requested_at" => "2013-02-16 21:38:28 -0700",
  #   })
  #
  #   assert payload.invalid?
  # end
  #
  # def test_empty_string_payload_request_is_invalid
  #   payload = PayloadRequest.create({
  #     "url"=> "",
  #     "requested_at" => "",
  #     "responded_in"=> "",
  #     "reference"=>"http://jumpstartlab.com",
  #     "request_type"=>"GET",
  #     "parameters"=>[],
  #     "event_name"=> "socialLogin",
  #     "user_agent"=>"Mozilla/5.0 ",
  #     "resolution_width"=>"1920",
  #     "resolution_height"=>"1280",
  #     "ip"=>"63.29.38.211"
  #   })
  #
  #   assert payload.invalid?
  # end
  #
  # def test_nil_payload_request_is_invalid
  #   payload = PayloadRequest.create({
  #     "url"=> nil,
  #     "requested_at" => nil,
  #     "responded_in"=> nil,
  #     "reference"=>"http://jumpstartlab.com",
  #     "request_type"=>"GET",
  #     "parameters"=>[],
  #     "event_name"=> "socialLogin",
  #     "user_agent"=>"Mozilla/5.0 ",
  #     "resolution_width"=>"1920",
  #     "resolution_height"=>"1280",
  #     "ip"=>"63.29.38.211"
  #   })
  #
  #   assert payload.invalid?
  # end

  def test_it_has_relationship_with_url
    assert_respond_to(@payload, :urls)
  end

  def test_it_has_relationship_with_reference
    assert_respond_to(@payload, :references)
  end

  def test_it_has_relationship_with_request_type
    assert_respond_to(@payload, :request_types)
  end

  def test_it_has_relationship_with_event_name
    assert_respond_to(@payload, :event_names)
  end

  def test_it_has_relationship_with_software_agents
    assert_respond_to(@payload, :software_agents)
  end

  def test_it_has_relationship_with_resolution
    assert_respond_to(@payload, :resolutions)
  end

  def test_it_has_relationship_with_ip_address
    assert_respond_to(@payload, :ip_addresses)
  end

  def test_it_can_create_n_number_raw_payloads
    assert_equal 3, create_payloads(3).count
  end

  # def test_it_can_find_average_response_time
  #   #find or create method in active record
  #   #Url.where().first_or_create
  #   #ULr.find_or_create_by
  #   #check return value
  #   p1= PayloadRequest.create(
  #   requested_at: Time.now,
  #   parameters: [],
  #   responded_in: 40,
  #   ip_address_id: 1,
  #   software_agent_id: 1,
  #   request_type_id: 1,
  #   url_id: 1,
  #   #url = URL.create(...)
  #   reference_id: 1,
  #   event_name_id: 1,
  #   resolution_id: 1
  #   )
  #   p1= PayloadRequest.create(
  #   requested_at: Time.now,
  #   parameters: [],
  #   responded_in: 35,
  #   ip_address_id: 1,
  #   software_agent_id: 1,
  #   request_type_id: 1,
  #   url_id: 1,
  #   reference_id: 1,
  #   event_name_id: 1,
  #   resolution_id: 1
  #   )
  #   p1= PayloadRequest.create(
  #   requested_at: Time.now,
  #   parameters: [],
  #   responded_in: 37,
  #   ip_address_id: 1,
  #   software_agent_id: 1,
  #   request_type_id: 1,
  #   url_id: 1,
  #   reference_id: 1,
  #   event_name_id: 1,
  #   resolution_id: 1
  #   )
  #
  #   assert_equal 35, PayloadRequest.average_response_time
  #
  # end
end
