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

  it "will find all unique screen resolutions" do
    ScreenResolution.create("width" =>"1920", "height" => "1280")
    ScreenResolution.create("width" =>"1280", "height" => "720")
    ScreenResolution.create("width" =>"1920", "height" => "1280")
    ScreenResolution.create("width" =>"1920", "height" => "720")
    ScreenResolution.create("width" =>"1280", "height" => "1080")

    expect(ScreenResolution.display_resolutions).to eq([["1920", "1280"], ["1280", "720"], ["1920", "720"], ["1280", "1080"]])
  end

  it "will find screen resolutions by payload request id" do
    screen_resolutions = [["1920", "1280"], ["1280", "720"], ["1920", "720"], ["1280", "1080"]]
    screen_resolutions.each do |pair|
      ScreenResolution.create("width" => pair[0],
                              "height" => pair[1])
                            end

    [1,2,3,4,2,3,3,4,4].each do |screen_res_id|
      PayloadRequest.create(
                  "url_id"=>1,
                  "requested_at"=>"2013-02-16 21:38:28 -0700",
                  "responded_in"=>30,
                  "source_id"=>2,
                  "request_type_id"=>3,
                  "u_agent_id"=>5,
                  "screen_resolution_id"=>screen_res_id,
                  "ip_address_id"=>6,
                  "client_id"=>10)
                end

    expect(ScreenResolution.all_display_resolutions).to eq({2=>{"width"=>"1280", "height"=>"720", "count"=>2},
                                                            4=>{"width"=>"1280", "height"=>"1080", "count"=>3},
                                                            1=>{"width"=>"1920", "height"=>"1280", "count"=>1},
                                                            3=>{"width"=>"1920", "height"=>"720", "count"=>3}})
  end
end
