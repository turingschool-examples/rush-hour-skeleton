require './test/test_helper'

class ApplicationDetailsTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
    TestData.payloads.each do |payload|
      data = PayloadParser.parse(payload)
      PayloadValidator.validate(data)
    end
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_finds_and_list_urls_from_most_Requested_to_least_requested
    require 'pry' ; binding.pry
    result = ApplicationDetails.sort_tracked_sites
    assert_equal "http://yahoo.com/weather", result.first

  end
end
