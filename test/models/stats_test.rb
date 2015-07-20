require_relative '../test_helper'

class StatsTest  < Minitest::Test

  def test_it_returns_url_stats
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })

    assert AppDataHandler.new("jumpstartlab").url_stats
  end

  def test_it_returns_browser_stats
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    DataProcessingHandler.new(@raw_payload, "jumpstartlab")

    assert_equal 1, AppDataHandler.new("jumpstartlab").browser_stats.count
  end

  def test_it_returns_os_stats
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    DataProcessingHandler.new(@raw_payload, "jumpstartlab")

    assert_equal 1, AppDataHandler.new("jumpstartlab").os_stats.count
  end

  def test_it_returns_resolution_stats
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    DataProcessingHandler.new(@raw_payload, "jumpstartlab")

    assert_equal 1, AppDataHandler.new("jumpstartlab").resolution_stats.count
  end

  def test_it_returns_response_times
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    DataProcessingHandler.new(@raw_payload, "jumpstartlab")

    assert AppDataHandler.new("jumpstartlab").response_times.count
  end

  def test_it_returns_link_lists
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    DataProcessingHandler.new(@raw_payload, "jumpstartlab")

    assert AppDataHandler.new("jumpstartlab").link_list.count
  end
end
