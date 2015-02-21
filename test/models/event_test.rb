require "./test/test_helper"
# one event says....hey payloads find all my payloads where payload.event_id == event.id
# this returns a collection of payloads where payload.event_id == event.id
# then look at each payload.requested_At

class EventTest < MiniTest::Test

  # def teardown
  #   DatabaseCleaner.clean
  # end
  #
	# def test_an_event_can_identify_attributes
	# 	event = Event.create( :name => "startedRegistration" )
	# 	assert_equal "startedRegistration", event.name
	# end
  #
	# def test_event_can_find_its_requested_hour
	# 	skip
	# 	event = Event.create( :name => "startedRegistration" )
  #
	# 	payload = event.payloads.create( :requested_at => "2013-02-16 21:38:28 -0700" )
	# 	assert_equal 21, event.requested_at_hour
	# end
  #
	# def test_event_can_find_all_requested_hours
	# 	skip
	# 	event = Event.create( :name => "startedRegistration" )
  #
	# 	event.payloads.create( :requested_at => "2013-02-16 21:38:28 -0700" )
	# 	event.payloads.create( :requested_at => "2011-02-16 10:38:28 -0700" )
	# 	event.payloads.create( :requested_at => "2012-02-16 13:38:28 -0700" )
  #
	# 	assert_equal [21, 10, 13], event.requested_at_hour
	# end
  #
	# def test_it_returns_number_of_instances_each_event_occured_by_hour
	# 	skip
	# 	event = Event.create( :name => "startedRegistration" )
  #
	# 	event.payloads.create( :requested_at => "2013-02-16 00:38:28 -0700" )
	# 	event.payloads.create( :requested_at => "2013-02-16 01:38:28 -0700" )
	# 	event.payloads.create( :requested_at => "2011-02-16 01:58:28 -0700" )
	# 	event.payloads.create( :requested_at => "2012-02-16 03:38:28 -0700" )
	# 	event.payloads.create( :requested_at => "2012-02-16 03:18:28 -0700" )
	# 	event.payloads.create( :requested_at => "2012-02-16 03:01:28 -0700" )
	# 	event.payloads.create( :requested_at => "2012-02-16 03:22:28 -0700" )
  #
	# 	assert_equal {0=>1, 1=>2, 3=>4}, event.hour_by_hour_breakdown
	# end
  #
  #
	# def test_can_find_total_number_of_each_event_by_name_from_most_to_least
	# 	skip
	# 	event1 = Event.create( :name => "startedRegistration" )
	# 	event2 = Event.create( :name => "startedRegistration" )
	# 	event3 = Event.create( :name => "addedSocialThroughPromptA" )
	# 	event4 = Event.create( :name => "addedSocialThroughPromptA" )
	# 	event5 = Event.create( :name => "addedSocialThroughPromptA" )
	# 	event6 = Event.create( :name => "addedSocialThroughPromptB" )
  #
	# 	events_by_total = { "addedSocialThroughPromptA" => 3,
	# 														"startedRegistration" => 2,
	# 											"addedSocialThroughPromptB" => 1}
	# 	assert_equal events_by_total,  event.most_to_least_received_events
	# end
  #
	# def test_it_can_return_the_total_number_of_events
  #   skip
	# 	event1 = Event.create( :name => "startedRegistration" )
	# 	event2 = Event.create( :name => "startedRegistration" )
	# 	event3 = Event.create( :name => "addedSocialThroughPromptA" )
	# 	event4 = Event.create( :name => "addedSocialThroughPromptA" )
	# 	event5 = Event.create( :name => "addedSocialThroughPromptA" )
	# 	event6 = Event.create( :name => "addedSocialThroughPromptB" )
  #
	# 	events_by_total = { "addedSocialThroughPromptA" => 3,
	# 														"startedRegistration" => 2,
	# 											"addedSocialThroughPromptB" => 1}
	# 	assert_equal 7,  event.event_total
	# end
end
