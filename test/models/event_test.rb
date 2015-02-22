require "./test/test_helper"

class EventTest < MiniTest::Test

  def teardown
    DatabaseCleaner.clean 
  end

	def test_an_event_can_identify_attributes

		event = Event.create( :name => "startedRegistration" )
		assert_equal "startedRegistration", event.name
	end

	def test_event_can_find_its_requested_hour
		
		event = Event.create( :name => "startedRegistration" )

		date = DateTime.new(2001,2,3,7,5,6)
	
		event.payloads.create( requested_at: date )
		assert_equal [7], event.requested_at_hour
	end

	def test_event_can_find_all_requested_hours
		
		date1 = DateTime.new(2013,2,16,21,38,28)
		date2 = DateTime.new(2013,2,16,10,38,28)
		date3 = DateTime.new(2013,2,16,13,38,28)

		event = Event.create( :name => "startedRegistration" )
		
		event.payloads.create( :requested_at => date1 )
		event.payloads.create( :requested_at => date2 )
		event.payloads.create( :requested_at => date3 )

		assert_equal [21, 10, 13], event.requested_at_hour
	end

	def test_it_returns_number_of_instances_each_event_occured_by_hour
		
		event = Event.create( :name => "startedRegistration" )

		date1 = DateTime.new(2013,2,16,21,38,28)
		date2 = DateTime.new(2013,2,16,10,38,28)
		date3 = DateTime.new(2013,2,16,13,38,28)

		event.payloads.create( :requested_at => date1 )
		event.payloads.create( :requested_at => date2 )
		event.payloads.create( :requested_at => date3 )

		hours_hash = { 	0=>0, 1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 
										6=>0, 7=>0, 8=>0, 9=>0, 10=>1, 11=>0, 
										12=>0, 13=>1, 14=>0, 15=>0, 16=>0, 17=>0, 
										18=>0, 19=>0, 20=>0, 21=>1, 22=>0, 23=>0 }

		assert_equal hours_hash, event.hour_by_hour_breakdown
	end


	def test_can_find_total_number_of_each_event_by_name_from_most_to_least

		event = Event.create( :name => "startedRegistration" )	
		event = Event.create( :name => "startedRegistration" )
		event = Event.create( :name => "addedSocialThroughPromptA" )
		event = Event.create( :name => "addedSocialThroughPromptA" )
		event = Event.create( :name => "addedSocialThroughPromptA" )
		event = Event.create( :name => "addedSocialThroughPromptB" )

		events_by_total = { "startedRegistration" => 2,
									"addedSocialThroughPromptA" => 3,
									"addedSocialThroughPromptB" => 1}

		assert_equal events_by_total,  event.most_to_least_received_events	
	end

	def test_it_can_return_the_total_number_of_events
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

		events_by_total = { "addedSocialThroughPromptA" => 2,
															"startedRegistration" => 3, 
												"addedSocialThroughPromptB" => 4}
		assert_equal 9,  events.count
	end

end