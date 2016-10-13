require_relative '../spec_helper'

RSpec.describe "When a valid user views URL data" do
  it "Shows url" do
    new_client
    new_payload
    visit("/sources/google/urls/about")
    within("#url") do
      expect(page).to have_content("URL: http://google.com/about")
    end
  end

  it "Shows url stats" do
    new_client
    new_payload
    second_payload
    visit("/sources/google/urls/about")
    within("#url_stats") do
      expect(page).to have_content("Max Response Time: 90")
      expect(page).to have_content("Min Response Time: 32")
      expect(page).to have_content("Longest To Shortest Response Time (in ms): [90, 32]")
      expect(page).to have_content("Average Response Time: 61")
      expect(page).to have_content('List of HTTP Verbs: ')
      expect(page).to have_content('GET')
      expect(page).to have_content('Three Most Popular Referrers: ')
      expect(page).to have_content("http://apple.com")
      expect(page).to have_content("http://apple.com/research")
      expect(page).to have_content('Three Most Popular User Agents ')
      expect(page).to have_content("Chrome")
      expect(page).to have_content("Macintosh")
    end
  end
end
