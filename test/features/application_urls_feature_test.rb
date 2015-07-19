require_relative '../test_helper'

class ApplicationUrlsTest < FeatureTest

  def test_it_has_a_header
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37)
    @url.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :event_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("URL Statistics")
  end

  def test_it_has_longest_response
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37)
    @url.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :event_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("Longest Response Time: 37")
  end

  def test_it_has_shortest_response
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37)
    @url.save
    @url2 = Url.new(:id => 3, :url => "http://jumpstartlab.com/blog", :responded_in => 7)
    @url2.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :event_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("Shortest Response Time: 7")
  end

  def test_it_has_average_response
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37)
    @url.save
    @url2 = Url.new(:id => 3, :url => "http://jumpstartlab.com/blog", :responded_in => 7)
    @url2.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :event_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("Average Response Time: 22")
  end

  def test_it_has_http_verbs
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37, :request_type => "GET")
    @url.save
    @url2 = Url.new(:id => 3, :url => "http://jumpstartlab.com/blog", :responded_in => 7, :request_type => "GET")
    @url2.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :event_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("Request Type Used: GET")
  end

end
