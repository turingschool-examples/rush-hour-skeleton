require './test/test_helper'
require './test/create_sources_and_payloads'

class UrlTest < Minitest::Test
  include CreateSourcesAndPayloads

  def test_urls_can_be_added_to_table
    TrafficSpy::Url.create(name: "jumpstartlab")

    url = TrafficSpy::Url.last
    assert_equal "jumpstartlab", url.name
  end

  def test_can_give_average_response_time
    TrafficSpy::Url.create(name: "http://jumpstartlab.com/blog")

    url = TrafficSpy::Url.last
    source = CreateSourcesAndPayloads.create_source("jumpstartlab", "http://www.jumpstartlab.com")
    CreateSourcesAndPayloads.create_payload("#{url.name}",
                                            "2014-02-16 21:38:28 -0700",
                                            40,
                                            "http://jumpstartlab.com",
                                            "GET",
                                            [],
                                            "socialLogin",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                            "1920",
                                            "1280",
                                            "63.29.38.211",
                                            source)
    CreateSourcesAndPayloads.create_payload("#{url.name}",
                                            "2014-03-13 21:38:30 -0700",
                                            6,
                                            "http://jumpstartlab.com",
                                            "GET",
                                            [],
                                            "socialLogin",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                            "1920",
                                            "1280",
                                            "63.29.38.211",
                                            source)
    CreateSourcesAndPayloads.create_payload("#{url.name}",
                                            "2015-03-12 21:38:00 -0800",
                                            6,
                                            "http://jumpstartlab.com",
                                            "GET",
                                            [],
                                            "socialLogin",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                            "1920",
                                            "1280",
                                            "63.29.38.210",
                                            source)

    CreateSourcesAndPayloads.create_payload("#{url.name}",
                                            "2015-03-10 21:38:05 -0800",
                                            18,
                                            "http://jumpstartlab.com",
                                            "GET",
                                            [],
                                            "socialLogin",
                                            "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                            "1920",
                                            "1280",
                                            "63.29.38.210",
                                            source)
    assert_equal 18, url.average_response_time
  end

end