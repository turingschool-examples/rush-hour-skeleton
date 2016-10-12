require_relative '../spec_helper'

describe "When a user visits '/sources/:IDENTIFIER/urls/:RELATIVEPATH'" do
  it "sees response time on relative path page" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    expect(page).to have_content("20")
  end

  it "sees max response time at time on relative path page" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    expect(page).to have_content("30")
  end

  it "sees min response time at time on relative path page" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    expect(page).to have_content("10")
  end

  it "sees list of http verbs" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    expect(page).to have_content("GET")
  end

  it "sees list of top three referrers" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    expect(page).to have_content("google.com/images")
  end
  it "sees list of top three agents" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    expect(page).to have_content("Safari OSX")
  end

end
