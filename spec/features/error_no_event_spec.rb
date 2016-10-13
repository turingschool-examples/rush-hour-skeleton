require_relative '../spec_helper'

RSpec.describe "When a user enters an event that does not exist" do
  it "Gives error message" do
    new_client
    new_payload
    visit("/sources/google/events/dogs")
    within("#event_error") do
      expect(page).to have_content("Error: No Event With Given Name Has Been Defined")
    end
  end

  it "Links to events index" do
    new_client
    new_payload
    visit("/sources/google/events/dogs")
    within("#events_index") do
      expect(page).to have_content("Events Index")
    end
  end
end
