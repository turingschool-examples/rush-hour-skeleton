require './test/test_helper'

class UrlTest < Minitest::Test

  def test_urls_can_be_added_to_table
    TrafficSpy::Url.create(name: "jumpstartlab")

    url = TrafficSpy::Url.last
    assert_equal "jumpstartlab", url.name
  end

end