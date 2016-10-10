require_relative '../spec_helper'
require 'pry'

describe Processor do
  it "returns hash with proper root_url key case" do
    params = {identifier: "test_id", rootUrl: "test_url"}
    expected = {identifier: "test_id", root_url: "test_url"}

    expect(Processor.clean_data(params)).to eq(expected)
  end

  it "returns nil root_url if rootUrl case is incorrect" do
    params = {identifier: "test_id", root_url: "test_url"}
    expected = {identifier: "test_id", root_url: nil}

    expect(Processor.clean_data(params)).to eq(expected)
  end

  it "returns referred by ID" do
    #1. clean our test data with params_cleaner_method
    #2. params_cleaner created a ReferredBy instance
    #3. now can serach for RefferBy(1).rooturl to see the output
    pc = Processor.params_cleaner(test_data)

    #not sure which one you like better or if i did it correct. we can take a look on 10/9
    expect(ReferredBy.find_by(root_url: "jumpstartlab.com").id).to eq(1)
    expect(ReferredBy.find(1).root_url).to eq("jumpstartlab.com")
  end

end
