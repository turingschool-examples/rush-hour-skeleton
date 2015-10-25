require './test/test_helper'
class SourceApplicationDetailsTest < Minitest::Test

  def test_payloads_are_being_added_to_database
    sources = TrafficSpy::Source
    payloads = TrafficSpy::Payload
    create_sources(5)
    create_payloads(5)
    
    assert_equal 5, sources.all.count
    assert_equal 5, payloads.all.count
  end
end
