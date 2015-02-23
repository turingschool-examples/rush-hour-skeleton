require "./test/test_helper"

class EventIndexTest < FeatureTest


  def payload_generator
    params = '{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    identifier = "jumpstartlab"

    PayloadGenerator.call(params, identifier)
  end

  def test_user_sees_events_page_greeting
    Source.create(:identifier => "jumpstartlab",
                   :root_url => "jump.com")
    payload_generator        

    visit "/sources/jumpstartlab/events"
    assert page.has_content?("Received Events")
  end

  def test_user_sees_index_and_links_to_details
    source = Source.create!(:identifier => "jumpstartlab",
                            :root_url => "jump.com")

    events = []

    events << Event.create( :name => "startedRegistration" )
    events << Event.create( :name => "addedSocialThroughPromptA" )
    events << Event.create( :name => "addedSocialThroughPromptB" )

    3.times do
      Payload.create!(:source_id => source.id, :url_id => 1,
                      :requested_at => DateTime.new, :responded_in => 1,
                      :request_type_id => 1, :event_id => events[0].id,
                      :payload_user_agent_id => 1, :resolution_id => 1, :ip_id => 1,
                      :reference_id =>1,
                      :digest => "abcdefg12345677")
    end

    2.times do
      Payload.create!(:source_id => source.id, :url_id => 1,
                      :requested_at => DateTime.new, :responded_in => 1,
                      :request_type_id => 1, :event_id => events[1].id,
                      :payload_user_agent_id => 1, :resolution_id => 1, :ip_id => 1,
                      :reference_id =>1,
                      :digest => "abcdefg12345677")
    end

    4.times do
      Payload.create!(:source_id => source.id, :url_id => 1,
                      :requested_at => DateTime.new, :responded_in => 1,
                      :request_type_id => 1, :event_id => events[2].id,
                      :payload_user_agent_id => 1, :resolution_id => 1, :ip_id => 1,
                      :reference_id =>1,
                      :digest => "abcdefg12345677")
    end

    visit "/sources/jumpstartlab/events"
    expected_event_names = ['addedSocialThroughPromptB',
                            'startedRegistration',
                            'addedSocialThroughPromptA']

    actual_event_names = page.all("#events li").map {|link| link.text }
    assert_equal expected_event_names, actual_event_names
  end
end
