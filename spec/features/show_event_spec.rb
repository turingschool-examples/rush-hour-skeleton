require_relative '../spec_helper'

RSpec.describe "When a valid user views event data" do
  it "Shows event name" do
    new_client
    new_payload
    visit("/sources/google/events/show")
    within("#event_name") do
      expect(page).to have_content("Event: show")
    end
  end

  it "Shows hours and count" do
    new_client
    new_payload
    second_payload
    visit("/sources/google/events/show")
    within("#hours") do
      expect(page).to have_content("Hour: 6:00, Count: 1")
      expect(page).to have_content("Hour: 5:00, Count: 1")
    end
  end
end
