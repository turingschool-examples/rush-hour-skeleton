require './spec/spec_helper'
require './app/controllers/data_parser'

RSpec.describe DataParser, type: :model do

  after :each do
    DatabaseCleaner.clean
  end

  let(:dp) { DataParser.new(sample_payload) }
  let(:create_url) { Url.create("address" => "http://jumpstartlab.com/blog") }
  let(:create_source) { Source.create("address" => "http://jumpstartlab.com") }

  def sample_payload
    JSON.generate({"url":"http://jumpstartlab.com/blog",
     "requestedAt":"2013-02-16 21:38:28 -0700",
     "respondedIn":37,
     "referredBy":"http://jumpstartlab.com",
     "requestType":"GET",
     "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
     "resolutionWidth":"1920",
     "resolutionHeight":"1280",
     "ip":"63.29.38.211"})
  end

  it "is initialized with a payload" do
    expect(dp.payload).to eq(sample_payload)
  end

  it "parses incoming json payload into ruby hash" do
    expect(dp.parse).to eq(JSON.parse(sample_payload))
  end

  it "checks if url exists in the urls table" do
    expect(dp.url_exists?).to eq(false)

    create_url

    expect(dp.url_exists?).to eq(true)
  end

  it "will create a new url object and return its id" do
    expect(dp.create_url_return_id).to eq(1)
  end

  it "will find a existing url object and return its id" do
    create_url
    expect(dp.return_existing_url_id).to eq(1)
  end

  it "will return a url id whether or not it finds a preexisting url" do
    2.times { expect(dp.url_id).to eq(1) }
  end

  it "checks if source exists in the sources table" do
    expect(dp.source_exists?).to eq(false)

    create_source

    expect(dp.source_exists?).to eq(true)
  end

  it "will create a new source object and return its id" do
    expect(dp.create_source_return_id).to eq(1)
  end

  it "will find a existing source object and return its id" do
    create_source
    expect(dp.return_existing_source_id).to eq(1)
  end

  it "will return a source id whether or not it finds a preexisting source" do
    2.times { expect(dp.source_id).to eq(1) }
  end


  it "parses a payload" do
    parsed_payload = {
      "url_id" => 1,
      "requested_at" => "2013-02-16 21:38:28 -0700",
      "responded_in" => 37
    }
    expect(dp.parse_payload).to eq(parsed_payload)
  end


end
