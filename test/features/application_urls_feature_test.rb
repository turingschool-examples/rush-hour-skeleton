require_relative '../test_helper'

class ApplicationUrlsTest < FeatureTest

  def test_it_has_a_header
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37, :request_type => "GET",
    :referred_by => "myspace.com")
    @url.save

    os = OperatingSystem.new(:id => 1, :name => "Mac")
    os.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :operating_system_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("URL Statistics")
  end

  def test_it_has_longest_response
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37, :request_type => "GET",
    :referred_by => "myspace.com")
    @url.save

    os = OperatingSystem.new(:id => 1, :name => "Mac")
    os.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :operating_system_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("Longest Response Time: 37")
  end

  def test_it_has_average_response
    skip
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37, :request_type => "GET",
    :referred_by => "myspace.com")
    @url.save
    os = OperatingSystem.new(:id => 1, :name => "Mac")
    os.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :operating_system_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("Average Response Time: 22")
  end

  def test_it_has_http_verbs
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37, :request_type => "GET",
    :referred_by => "myspace.com")
    @url.save

    os = OperatingSystem.new(:id => 1, :name => "Mac")
    os.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :operating_system_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("Request Type Used: GET")
  end

end
