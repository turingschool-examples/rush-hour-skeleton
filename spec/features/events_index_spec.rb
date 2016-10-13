require_relative '../spec_helper'

RSpec.describe "When a user views events index" do
  it "Shows header" do
    new_client
    visit("/sources/google/events_index")
    within("#events_index") do
      expect(page).to have_content("Index of Events for Google")
    end
  end

  it "Links to events" do
    new_client
    new_payload
    visit("/sources/google/events_index")
    within("#events_list") do
      expect(page).to have_content("show")
    end
  end
end
