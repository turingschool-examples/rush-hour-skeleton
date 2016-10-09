require_relative '../spec_helper'

RSpec.describe "Client" do
  
  it "is valid with everything" do
    client = Client.new(identifier: "bah", root_url: "foo")
    
    expect(client).to be_valid
  end
  
  it "is invalid without an identifier" do
    client = Client.new(root_url: "foo")
    
    expect(client).to_not be_valid
  end
  
  it "is invalid without a root url" do
    client = Client.new(identifier: "foo")
    
    expect(client).to_not be_valid
  end
  
  it "can access payload information" do
    client = Client.create(identifier: "Alphonse", root_url: "http://beesbeesbees.com")
    
    payload1 = Payload.create(url_id: 1,
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 39,
                          referred_by_id: 1,
                          request_type_id: 1,
                          event_name_id: 1,
                          agent_id: 1,
                          resolution_id: 1,
                          ip_id: 1,
                          client_id: 1)

    payload2 = Payload.create(url_id: 1,
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          referred_by_id: 1,
                          request_type_id: 2,
                          event_name_id: 1,
                          agent_id: 1,
                          resolution_id: 1,
                          ip_id: 1,
                          client_id: 1)

    payload3 = Payload.create(url_id: 1,
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 34,
                          referred_by_id: 2,
                          request_type_id: 5,
                          event_name_id: 1,
                          agent_id: 2,
                          resolution_id: 1,
                          ip_id: 1)
                          
    expect(client.payloads.count).to eq(2)
    expect(client.payloads.first.url_id).to eq(1)
  end
  
  
end