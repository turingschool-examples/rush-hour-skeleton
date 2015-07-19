require_relative '../test_helper'

class ApplicationUrlsTest < FeatureTest

  def test_it_has_a_header
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog")
    @url.save
    event   = Event.new(:id => 1, :responded_in => 33)
    event.save
    payload = Payload.new(:registration_id => 1, :url_id => 2, :event_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("URL Statistics")
  end

end
