require './spec/spec_helper'
require './app/controllers/server'

RSpec.describe RushHour::Server, type: :model do
  def app
    RushHour::Server
  end

  after :each do
    DatabaseCleaner.clean
  end

  it "knows if paramaters contain identifier and root_url" do
    post '/sources'
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq("Parameters must include identifier and root url.")

    post '/sources', {"identifier" => "jumpstartlab"}
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq("Parameters must include identifier and root url.")

    post '/sources', {"root_url" => "www.jumpstartlab.com"}
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq("Parameters must include identifier and root url.")
  end

  it "returns status 403 if client already exists" do
    Client.create("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab.com")

    post '/sources', {"identifier" => "jumpstartlab",
                      "root_url" => "www.jumpstartlab.com"}

    expect(last_response.status).to eq(403)
    expect(last_response.body).to eq("Client already exists")
  end

  it "returns status 200 and identifier message when it creates a new client" do
    post '/sources', {"identifier" => "jumpstartlab",
                      "root_url" => "www.jumpstartlab.com"}

    expected_body = JSON.generate({"identifier" => "jumpstartlab"})
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq(expected_body)
  end



end
