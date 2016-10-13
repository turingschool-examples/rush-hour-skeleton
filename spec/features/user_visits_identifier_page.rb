require_relative '../spec_helper'

describe "When a user visits '/sources/:IDENTIFIER'" do
  it "sees respond time on identifier page" do
    create_single_client_and_payload
    visit("/sources/google")
    within(".avg-response") do
      expect(page).to have_content("12")
    end
  end

  it "sees max response time on identifier page" do
    create_single_client_and_payload
    visit("/sources/google")
    within(".max-response") do
      expect(page).to have_content("12")
    end
  end

  it "sees min response time on identifier page" do
    create_single_client_and_payload
    visit("/sources/google")
    within(".min-response") do
      expect(page).to have_content("12")
    end
  end

  it "sees most frequent request type on identifier page" do
    create_single_client_and_payload
    visit("/sources/google")
    within(".min-response") do
      expect(page).to have_content("12")
    end
  end

  it "sees refered by list on identifier page" do
    create_single_client_and_payload
    visit("/sources/google")
    within(".most-frequent") do
      expect(page).to have_content("GET")
    end
  end

  it "sees browser on identifier page" do
    create_single_client_and_payload
    visit("/sources/google")
    within(".browser") do
      expect(page).to have_content("Safari: 1")
    end
  end

  it "sees operating system on identifier page" do
    create_single_client_and_payload
    visit("/sources/google")
    within(".os") do
      expect(page).to have_content("OSX: 1")
    end
  end

  it "sees screen resolution on identifier page" do
    create_single_client_and_payload
    visit("/sources/google")
    within(".res-height") do
      expect(page).to have_content("1800")
    end
    within(".res-width") do
      expect(page).to have_content("1200")
    end
    within(".res-count") do
      expect(page).to have_content("1")
    end
  end

end
