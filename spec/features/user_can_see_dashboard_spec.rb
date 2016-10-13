require_relative "../spec_helper"
require 'pry'

RSpec.describe "when a user visits /" do
  it "they see the welcome message" do

    visit("/")
    expect(page).to have_content("Welcome to Rush Hour!")
  end

  it "they see the access data button" do

    visit("/")
    within("//div[@class='jumbotron row-centered form-inline']") do
    expect find_button("access data")
    end
  end
end
