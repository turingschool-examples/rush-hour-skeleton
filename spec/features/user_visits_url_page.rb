require_relative '../spec_helper'

describe "When a user visits '/sources/:IDENTIFIER/urls/:RELATIVEPATH'" do
  it "sees average response time on relative path page" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    within(".avg-response") do
      expect(page).to have_content("20")
    end
  end

  it "sees max response time at time on relative path page" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    within(".max-response") do
      expect(page).to have_content("30")
    end
  end

  it "sees min response time at time on relative path page" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    within(".min-response") do
      expect(page).to have_content("10")
    end
  end

  it "sees list of http verbs" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    within(".all-verbs") do
      expect(page).to have_content("GET")
    end
  end

  it "sees list of top three referrers" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    expect(page).to have_content("google.com/images")
  end

  it "sees list of top three agents" do
    create_multiple_payloads_for_single_client
    visit("/sources/google/urls/images")
    within(".agents") do
      expect(page).to have_content("Safari OSX")
    end
  end

end
