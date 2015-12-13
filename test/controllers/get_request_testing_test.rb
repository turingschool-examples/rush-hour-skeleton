require_relative '../test_helper'

class GetRequestTest < Minitest::Test

  def setup
    Client.create({"name" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"})
    ph = PayloadHandler.new(payload)
  end

  def test_user_receives_200_status_when_accessing_homepage
    get '/'

    assert_equal 200, last_response.status
  end

  def test_user_receives_200_status_when_viewing_application_details
    get '/sources/jumpstartlab/'

    assert_equal 200, last_response.status
  end

  def test_user_receives_200_status_when_viewing_url_details
    get '/sources/jumpstartlab/urls/blog'

    assert_equal 200, last_response.status
  end

  def test_user_receives_200_status_when_viewing_event_index
    get '/sources/jumpstartlab/events'

    assert_equal 200, last_response.status
  end

  def test_user_receives_200_status_when_viewing_event_details
    get '/sources/jumpstartlab/events/socialLogin'

    assert_equal 200, last_response.status
  end

end
