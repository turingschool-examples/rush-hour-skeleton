require "./test/test_helper"

class CreateSourceTest < MiniTest::Test
  include Rack::Test::Methods

  attr_reader :source

  def setup
  @source =  { identifier: "jumpstartlab",
                   root_url: "http://jumpstartlab.com" }
  end

  def app
    TrafficSpy::Server
  end

  def teardown
    DatabaseCleaner.clean
  end

  def register_app
    Source.create(source)
  end

  def test_the_correct_url_is_created
    url = Url.create_url(source[:root_url], "blog")
    assert_equal "http://jumpstartlab.com/urls/blog", url
  end

  def test_when_the__url_does_not_exist_return_error
    register_app
    get "/sources/jumpstartlab/urls/kyra"
    assert_equal 404, last_response.status
  end

  def test_can_find_response_times
    register_app
    Payload.create(url_id: 1, requested_at: Date.today, responded_in: 40,
                   reference_id: 1, request_type_id: 1, event_id: 1,
                   user_agent_id: 1, resolution_id: 1, ip_id: 1, source_id: 1,
                   digest: "2e0fb001e51eab0509f6c480b1be7fb337c99766d1fb0708135751b6f8573blf")
    Payload.create(url_id: 1, requested_at: Date.today, responded_in: 36,
                    reference_id: 1, request_type_id: 1, event_id: 1,
                    user_agent_id: 1, resolution_id: 1, ip_id: 1, source_id: 1,
                    digest: "2e0fb001e51eab0509f6c480b1be7fb337c99766d1fb0708135751b6f8573bdd")
    Url.create(address: "http://jumpstartlab.com/urls/blog")
    get "/sources/jumpstartlab/urls/blog"
    assert_equal 40, Url.longest_response("http://jumpstartlab.com/urls/blog")
    assert_equal 36, Url.shortest_response("http://jumpstartlab.com/urls/blog")
    assert_equal 38, Url.average_response("http://jumpstartlab.com/urls/blog")
  end

end
