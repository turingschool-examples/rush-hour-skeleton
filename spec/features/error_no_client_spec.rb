require_relative '../spec_helper'

RSpec.describe "When a user enters an identifier that does not exist" do
  it "Gives error message" do
    visit("/sources/yahoo")
    within("#client_error") do
      expect(page).to have_content("Error: Identifier Does Not Exist")
    end
  end
end
