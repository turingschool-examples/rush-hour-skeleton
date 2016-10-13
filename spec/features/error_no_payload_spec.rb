require_relative '../spec_helper'

RSpec.describe "When a user enters an identifier with no data" do
  it "Gives error message" do
    new_client
    visit("/sources/google")
    within("#payload_error") do
      expect(page).to have_content("Error: No Payload Data Has Been Received For This Source")
    end
  end
end
