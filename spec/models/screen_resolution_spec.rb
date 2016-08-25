require './spec/spec_helper'
require './app/models/screen_resolution'

RSpec.describe ScreenResolution, type: :model do

  after :each do
      DatabaseCleaner.clean
    end

  let(:screen_resolution) { ScreenResolution.new("height" =>"1280", "width" => "1920")}

  it "takes a u agent and returns a u agent object" do
    expect(screen_resolution).to be_an_instance_of ScreenResolution
  end

  it "has a u agent height" do
    expect(screen_resolution.height).to eq("1280")
  end

  it "has a u agent width" do
    expect(screen_resolution.width).to eq("1920")
  end

  it "will not create a u agent without a height" do
    expect(ScreenResolution.new("height" => "")).to be_invalid
  end

  it "will not create a u agent without a width" do
    expect(ScreenResolution.new("width" => "")).to be_invalid
  end

  it "will not allow duplicate height" do
    ScreenResolution.create("height" =>"1280")
    expect(ScreenResolution.new("height" => "1280")).to be_invalid
  end

  it "will not allow duplicate width" do
    ScreenResolution.create("width" =>"1920")
    expect(ScreenResolution.new("width" => "1920")).to be_invalid
  end

  it "will find all screen resolutions" do
    ScreenResolution.create("width" =>"1920", "height" => "1280")
    ScreenResolution.create("width" =>"1280", "height" => "720")
    expect(ScreenResolution.display_resolutions).to eq([["1920", "1280"], ["1280", "720"]])
  end
end
