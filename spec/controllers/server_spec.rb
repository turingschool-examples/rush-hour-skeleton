require './spec/spec_helper'
require './app/controllers/server'

RSpec.describe RushHour::Server, type: :model do
  def app
    Sinatra::Application
  end

  it "loads server page" do
    post '/sources'
    expect(last_response.body).to include("Hello, World!")
  end

  skip "knows if paramaters contain identifier" do
    post'/sources', {params=>"identifier=jumpstartlab&rootUrl=http://jumpstartlab.com"}
    expect(response).to have_http_status(200)
  end

end
