require_relative '../test_helper'

class StatsTest  < Minitest::Test

  def test_it_returns_url_stats
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    assert AppDataHandler.new("jumpstartlab").url_stats
  end


  def test_it_returns_browser_stats
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @input = "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
    DataProcessingHandler.new(@input, "jumpstartlab")

    assert AppDataHandler.new("jumpstartlab").browser_stats
  end

  def test_it_returns_os_stats
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @input = "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
    DataProcessingHandler.new(@input, "jumpstartlab")

    assert AppDataHandler.new("jumpstartlab").os_stats
  end

  def test_it_returns_resolution_stats
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @input = "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
    DataProcessingHandler.new(@input, "jumpstartlab")

    assert AppDataHandler.new("jumpstartlab").resolution_stats
  end

  def test_it_returns_response_times
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @input = "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
    DataProcessingHandler.new(@input, "jumpstartlab")

    assert AppDataHandler.new("jumpstartlab").response_times
  end

  def test_it_returns_link_lists
    @registration = RegistrationHandler.new({ "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" })
    @input = "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
    DataProcessingHandler.new(@input, "jumpstartlab")

    assert AppDataHandler.new("jumpstartlab").link_list
  end

end
