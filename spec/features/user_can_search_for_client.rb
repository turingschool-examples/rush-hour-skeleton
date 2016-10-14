require_relative "../spec_helper"

RSpec.describe "When a user visits '/'" do
  it "they can login to their dashboard" do
    create_multiple_payloads_for_single_client
    visit("/")
    fill_in("search-id", with: "google")
    click_button("Submit")
    expect(current_path).to eq("/sources/google")
  end
end
