require_relative '../test_helper'

class RequestTest < Minitest::Test

  def request_data
    {
      :request_hash => '582782a967bdfb675f1c3445ded79782ae109f5a',
      :application_id => 1,
      :url_id => 2,
      :timestamp => '2013-02-16 21:38:28 -0700',
      :response_time => 37,
      :referral => 'http://jumpstartlab.com',
      :verb => 'GET',
      :event_id => 3,
      :browser => 'Chrome 24.0.1309',
      :os => 'Mac OS X 10.8.2',
      :resolution => '1920x1280'
    }
  end

  def test_application_is_created_with_valid_attributes
    Request.create(request_data)
    assert_equal request_data[:request_hash],   Request.last.request_hash
    assert_equal request_data[:application_id], Request.last.application_id
    assert_equal request_data[:url_id],         Request.last.url_id
    assert_equal request_data[:response_time],  Request.last.response_time
    assert_equal request_data[:referral],       Request.last.referral
    assert_equal request_data[:verb],           Request.last.verb
    assert_equal request_data[:event_id],       Request.last.event_id
    assert_equal request_data[:browser],        Request.last.browser
    assert_equal request_data[:os],             Request.last.os
    assert_equal request_data[:resolution],     Request.last.resolution
    assert                                      Request.last.timestamp.is_a? Time
  end

  def test_request_belong_to_application
    Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")
    req = Request.create(application_id: 1,request_hash: Digest::SHA1.hexdigest("1"))

    assert_equal 'jumpstartlab', req.application.identifier
  end

  def test_request_belong_to_url
    Url.create(path: 'http://jumpstartlab.com')
    req = Request.create(url_id: 1,request_hash: Digest::SHA1.hexdigest("1"))

    assert_equal 'http://jumpstartlab.com', req.url.path
  end
end
