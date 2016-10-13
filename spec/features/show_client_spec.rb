require_relative '../spec_helper'

RSpec.describe "When a valid user views their data" do
  it "Shows client page" do
    new_client
    new_payload
    visit("/sources/google")
    within("#client_name") do
      expect(page).to have_content("Google")
    end
  end

  it "Shows client stats" do
    new_client
    new_payload
    second_payload
    visit("/sources/google")
    within("#client_stats") do
      expect(page).to have_content("Average Response Time Across All Payloads: 61")
      expect(page).to have_content("Max Response Time Across All Payloads: 90")
      expect(page).to have_content("Min Response Time Across All Payloads: 32")
      expect(page).to have_content("Most Frequent Request Type: GET")
      expect(page).to have_content('List of all HTTP Verbs:')
      expect(page).to have_content('List of URLs, most requested to least requested: ')
      expect(page).to have_content("http://google.com/about")
      expect(page).to have_content('Web browser breakdown across all payloads ')
      expect(page).to have_content("Chrome")
      expect(page).to have_content("2")
      expect(page).to have_content('OS breakdown across all payloads ')
      expect(page).to have_content("Macintosh")
      expect(page).to have_content("Screen Resolutions across all payloads ")
      expect(page).to have_content("1920")
      expect(page).to have_content("1080")
    end
  end

  it "Shows relative path" do
    new_client
    new_payload
    second_payload
    visit("/sources/google")
    within("#path") do
      expect(page).to have_content("about")
    end
  end

end
