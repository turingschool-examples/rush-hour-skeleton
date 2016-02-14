require_relative '../test_helper'

class HourlyBreakdown < FeatureTest
  include TestHelpers

# http://yourapplication:port/sources/IDENTIFIER/events/EVENTNAME
#
# Examples:
#
# http://yourapplication:port/sources/jumpstartlab/events/startedRegistration
# http://yourapplication:port/sources/jumpstartlab/events/addedSocialThroughPromptA
# http://yourapplication:port/sources/jumpstartlab/events/addedSocialThroughPromptB
# Implement a hour by hour breakdown of when the event was received. How many were shown at noon? at 1pm? at 2pm? Do it for all 24 hours. Also, display on this page the overall number of times the specific event was received.
#
# When the event has not been defined: Display a message that no event with the given name has been defined and then a hyperlink to the Application Events Index.
  def user_can_view_hourly_breakdown_of_all_events
    # create_payload_1
    # create_payload_2
    # create_payload_3

    #user signs in with registered identifier

    #user clicks on event breakdown link


    #user clicks on specific event to view hourly_breakdown

    #user can see all events for the given event name by hour of occurrence
    #anduser can see total occurences for given event on given day.




    #user

  end




end
