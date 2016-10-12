require_relative '../spec_helper'

describe "When a user visits '/sources'" do
  it "sees source on sources page" do
    create_clients
    visit("/sources")
    within(".navbar") do
      save_and_open_page
      expect(page).to have_content("google")
      expect(page).to have_content("yahoo")
      expect(page).to have_content("facebook")
      expect(page).to have_content("apple")
      expect(page).to have_content("microsoft")
      expect(page).to have_content("jumpstartlab")
    end
  end

  it "can redirect to specific identifier's page" do
    create_single_client_and_payload
    visit("/sources")
    click_link('google')
    expect(page).to have_current_path("/sources/google")
  end


end
