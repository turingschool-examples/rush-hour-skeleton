require_relative '../test_helper'

class ApplicationUrlsTest < FeatureTest

  def test_it_has_a_header
    RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @url = Url.new(:id => 2, :url => "http://jumpstartlab.com/blog", :responded_in => 37)
    @url.save
    event   = Event.new(:id => 1, :name => "new event")
    event.save
    payload = Payload.new(:id => 1, :registration_id => 1, :url_id => 2, :event_id => 1)
    payload.save
    visit "/sources/jumpstartlab/urls#{@url.path}"
    assert page.has_content?("URL Statistics")
  end

end
