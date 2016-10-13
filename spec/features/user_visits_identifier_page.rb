require_relative '../spec_helper'

describe "When a user visits '/sources/:IDENTIFIER'" do
  it "sees respond time on sources page" do
    create_single_client_and_payload
    visit("/sources/google")
    expect(page).to have_content("12")
  end

  it "sees requested at time on sources page" do
    create_single_client_and_payload
    visit("/sources/google")
    expect(page).to have_content("GET")
  end

  it "sees refered by list on sources page" do
    create_single_client_and_payload
    visit("/sources/google")
    expect(page).to have_content("google.com/images")
  end

  it "sees browser on sources page" do
    create_single_client_and_payload
    visit("/sources/google")
    expect(page).to have_content("Safari")
  end

  it "sees operating system on sources page" do
    create_single_client_and_payload
    visit("/sources/google")
    expect(page).to have_content("OSX")
  end

  it "sees screen resolution on sources page" do
    create_single_client_and_payload
    visit("/sources/google")
    expect(page).to have_content("1200")
    expect(page).to have_content("1800")
    expect(page).to have_content("1")
  end

end
