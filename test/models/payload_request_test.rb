require_relative "../test_helper"

class PayloadRequestTest < Minitest::Test

  def setup
    @payload = PayloadRequest.new
  end

  def test_full_payload_request_is_valid
    payload = PayloadRequest.create({
      "url"=> "http://jumpstartlab.com/blog",
      "requested_at" => "2013-02-16 21:38:28 -0700",
      "responded_in"=>37,
      "referred_by"=>"http://jumpstartlab.com",
      "request_type"=>"GET",
      "parameters"=>[],
      "event_name"=> "socialLogin",
      "user_agent"=>"Mozilla/5.0 ",
      "resolution_width"=>"1920",
      "resolution_height"=>"1280",
      "ip"=>"63.29.38.211"
    })

    assert payload.valid?
  end

  def test_missing_line_payload_request_is_invalid
    payload = PayloadRequest.create({
      "url"=> "http://jumpstartlab.com/blog",
      "requested_at" => "2013-02-16 21:38:28 -0700",
    })

    assert payload.invalid?
  end

  def test_empty_string_payload_request_is_invalid
    payload = PayloadRequest.create({
      "url"=> "",
      "requested_at" => "",
      "responded_in"=> "",
      "referred_by"=>"http://jumpstartlab.com",
      "request_type"=>"GET",
      "parameters"=>[],
      "event_name"=> "socialLogin",
      "user_agent"=>"Mozilla/5.0 ",
      "resolution_width"=>"1920",
      "resolution_height"=>"1280",
      "ip"=>"63.29.38.211"
    })

    assert payload.invalid?
  end

  def test_nil_payload_request_is_invalid
    payload = PayloadRequest.create({
      "url"=> nil,
      "requested_at" => nil,
      "responded_in"=> nil,
      "referred_by"=>"http://jumpstartlab.com",
      "request_type"=>"GET",
      "parameters"=>[],
      "event_name"=> "socialLogin",
      "user_agent"=>"Mozilla/5.0 ",
      "resolution_width"=>"1920",
      "resolution_height"=>"1280",
      "ip"=>"63.29.38.211"
    })

    assert payload.invalid?
  end

  def test_it_has_relationship_with_url
    assert_respond_to(@payload, :urls)
  end

  def test_it_has_relationship_with_referred_by
    assert_respond_to(@payload, :referred_bys)
  end

  def test_it_has_relationship_with_request_type
    assert_respond_to(@payload, :request_types)
  end

  def test_it_has_relationship_with_event_name
    assert_respond_to(@payload, :event_names)
  end

  def test_it_has_relationship_with_user_agent
    assert_respond_to(@payload, :user_agents)
  end

  def test_it_has_relationship_with_resolution
    assert_respond_to(@payload, :resolutions)
  end

  def test_it_has_relationship_with_ip_address
    assert_respond_to(@payload, :ip_addresses)
  end
end
