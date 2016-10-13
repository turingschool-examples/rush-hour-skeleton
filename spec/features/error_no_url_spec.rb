require_relative '../spec_helper'

RSpec.describe "When a user enters a relative path that does not exist in a client's URLs" do
  it "Gives error message" do
    new_client
    new_payload
    visit("/sources/google/urls/dogs")
    within("#url_error") do
      expect(page).to have_content("Error: The URL Has Not Been Requested")
    end
  end
end
