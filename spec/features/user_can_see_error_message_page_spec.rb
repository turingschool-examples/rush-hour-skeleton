require_relative "../spec_helper"
require 'pry'

RSpec.describe "when a user visits /sources/doesNotExist" do
  it "they see the error message" do

    visit("/sources/doesNotExist")
    expect(page).to have_content("You tried to do a thing and it didn't work.")
  end
end
