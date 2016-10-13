require_relative '../spec_helper'

RSpec.describe "When a user enters a path that is not found" do
  it "Has title" do
    visit("/dogs")
    within("#error") do
      expect(page).to have_content("Error Page")
    end
  end

  it "Gives error message" do
    visit("/dogs")
    within("#missing_params") do
      expect(page).to have_content("Missing Parameters - 400 Bad Request")
    end
  end
end
