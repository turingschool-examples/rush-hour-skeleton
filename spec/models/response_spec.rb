require_relative '../spec_helper'

describe Response do
  it "returns 403 status when identifier already exists" do
    Client.create(identifier: "test_id", root_url: "test_url")
    client = Client.new({identifier: "test_id", root_url: "test_url"})
    client_identifier = "test_id"
    expected = {status: 403, body: "Identifier test_id already exists\n"}

    expect(Response.process_client(client, client_identifier)).to eq(expected)
  end

  it "returns 200 status if identifier does not already exists" do
    client = Client.new({identifier: "test_id", root_url: "test_url"})
    client_identifier = "test_id"
    expected = {status: 200, body: "{'identifier':'test_id'}\n"}

    expect(Response.process_client(client, client_identifier)).to eq(expected)
  end

  it "returns 400 status if root_url parameter is missing" do
    client = Client.new({identifier: "test_id"})
    client_identifier = "test_id"
    expected = {status: 400, body: "Root url can't be blank\n"}

    expect(Response.process_client(client, client_identifier)).to eq(expected)
  end

  it "returns 400 status if identifier parameter is missing" do
    client = Client.new({root_url: "test_url"})
    client_identifier = "test_id"
    expected = {status: 400, body: "Identifier can't be blank\n"}

    expect(Response.process_client(client, client_identifier)).to eq(expected)
  end

  it "returns 400 status if both parameters are missing" do
    client = Client.new()
    client_identifier = "test_id"
    expected = {status: 400, body: "Identifier can't be blank\nRoot url can't be blank\n"}

    expect(Response.process_client(client, client_identifier)).to eq(expected)
  end

  it "returns 403 status if identifier already exists and root_url is missing" do
    Client.create(identifier: "test_id", root_url: "test_url")
    client = Client.new({identifier: "test_id"})
    client_identifier = "test_id"
    expected = {status: 403, body: "Identifier test_id already exists\n"}

    expect(Response.process_client(client, client_identifier)).to eq(expected)
  end

  it "returns 403 status if identifier already exists and identifier is missing" do
    Client.create(identifier: "test_id", root_url: "test_url")
    client = Client.new({root_url: "test_url"})
    client_identifier = "test_id"
    expected = {status: 403, body: "Identifier test_id already exists\n"}

    expect(Response.process_client(client, client_identifier)).to eq(expected)
  end

  it "returns 403 status if client does not exist" do
    identifier = "test_identifier"
    expected = {status: 403, body: "Client test_identifier is not registered\n"}

    expect(Response.process_data(test_data, identifier)).to eq(expected)
  end

  it "returns 403 status if missing parameters and client exists" do
    Client.create(identifier: "test_identifier", root_url: "test_url")
    identifier = "test_identifier"
    data = {}
    expected = {:status=>403, :body=>"Missing parameters\n"}

    expect(Response.process_data(data, identifier)).to eq(expected)
  end

  it "returns 403 status if payload already exists" do
    Client.create(identifier: "test_identifier", root_url: "test_url")
    identifier = "test_identifier"
    expected = {:status=>403, :body=>"Payload already exists\n"}
    Response.process_data({:payload => test_data}, identifier)
    expect(Response.process_data({:payload => test_data}, identifier)).to eq(expected)
  end
end
