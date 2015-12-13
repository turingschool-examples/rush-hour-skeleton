require_relative "../test_helper"

class UserSeesCorrectErrorMessagesForSourcePage < FeatureTest

  def test_user_receives_identifier_does_not_exist_for_unregistered_sources
    ces = ClientEnvironmentSimulator.new
    ces.start_simulation

    visit '/sources/pretzels/'

    assert page.has_content?("The identifier does not exist.")

  end

  def test_user_receives_no_payload_data_message_if_no_data_has_been_received
    Client.create(name: "Turing", root_url: "http://turing.io")

    visit '/sources/Turing/'
    assert page.has_content?("No payload data has been received for this source.")
  end

end
