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

  def test_it_finds_and_list_urls_from_most_requested_to_least_requested
    result = ApplicationDetails.sort_tracked_sites
    require 'pry' ; binding.pry
    assert_equal "http://yahoo.com/weather", result.first
  end

  # def test_it_returns_an_array_of_urls_from_most_requested_to_least_requested
  #   result = ApplicationDetails.sort_tracked_sites
  #   expected = ["http://yahoo.com/weather", "http://yahoo.com/news", "http://google.com/about", "http://jumpstartlab.com/blog", "http://apple.com/blog"]
  #   assert_equal expected, result
  # end

end
