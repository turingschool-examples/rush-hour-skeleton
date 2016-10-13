require_relative '../spec_helper'

describe "When a user visits '/sources/:IDENTIFIER'" do
  it "sees counts by hour" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/events/socialLogin")
    expect(page).to have_content("4")
  end

end
