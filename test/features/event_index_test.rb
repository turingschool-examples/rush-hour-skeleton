require "./test/test_helper"

class EventIndexTest < FeatureTest

  def teardown
    DatabaseCleaner.clean 
  end
 
  def test_user_sees_events_page_greeting
  	source = Source.create!(:identifier => "jumpstartlab",
                            :root_url => "jump.com")

    visit "/sources/jumpstartlab/events"
    assert page.has_content?("Application Event Index")
  end 
   
  def test_user_sees_index_and_links_to_details
    source = Source.create!(:identifier => "jumpstartlab",
                            :root_url => "jump.com")

    events = []
    
    events << Event.create( :name => "startedRegistration" )
    events << Event.create( :name => "addedSocialThroughPromptA" )
    events << Event.create( :name => "addedSocialThroughPromptB" )

    3.times do
                Payload.create!(  :source_id => source.id, :url_id => 1, 
                                  :requested_at => DateTime.new, :responded_in => 1, 
                                  :request_type_id => 1, :event_id => events[0].id, 
                                  :user_agent_id => 1, :resolution_id => 1, :ip_id => 1,
                                  :reference_id =>1) 
    end

    2.times do
                Payload.create!(  :source_id => source.id, :url_id => 1, 
                                  :requested_at => DateTime.new, :responded_in => 1, 
                                  :request_type_id => 1, :event_id => events[1].id, 
                                  :user_agent_id => 1, :resolution_id => 1, :ip_id => 1,
                                  :reference_id =>1) 
    end

    4.times do
                Payload.create!(  :source_id => source.id, :url_id => 1, 
                                  :requested_at => DateTime.new, :responded_in => 1, 
                                  :request_type_id => 1, :event_id => events[2].id, 
                                  :user_agent_id => 1, :resolution_id => 1, :ip_id => 1,
                                  :reference_id =>1) 
    end
    
    visit "/sources/jumpstartlab/events"
    save_and_open_page
    expected_event_names = ['addedSocialThroughPromptB',
                            'startedRegistration', 
                            'addedSocialThroughPromptA']

    actual_event_names = page.all("#events li").map {|link| link.text }

    assert_equal expected_event_names, actual_event_names

  end 

end