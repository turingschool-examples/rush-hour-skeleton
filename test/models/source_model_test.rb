require './test/test_helper'

module TrafficSpy
  class SourceApplicationDetailsTest < Minitest::Test
    def setup
      TrafficSpy::Source.create({identifier: "jumpstartlab",
                                 root_url: "http://jumpstartlab.com"
                                })

      TrafficSpy::Payload.create({:url=>"http://jumpstartlab.com/blog",
                                  :requested_at=>"2013-02-16 21:38:28 -0700",
                                  :responded_in=>37,
                                  :referred_by=>"http://jumpstartlab.com",
                                  :request_type=>"GET",
                                  :parameters=>[],
                                  :event_name=>"socialLogin",
                                  :user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  :resolution_width=>"1920",
                                  :resolution_height=>"1280",
                                  :ip=>"63.29.38.211",
                                  :unique_hash=>"any old string",
                                  :source_id=> 1
                                  })

      TrafficSpy::Payload.create({:url=>"http://jumpstartlab.com/about",
                                  :requested_at=>"2013-02-16 21:38:28 -0700",
                                  :responded_in=>37,
                                  :referred_by=>"http://jumpstartlab.com",
                                  :request_type=>"GET",
                                  :parameters=>[],
                                  :event_name=>"socialLogin",
                                  :user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  :resolution_width=>"1920",
                                  :resolution_height=>"1280",
                                  :ip=>"63.29.38.211",
                                  :unique_hash=>"whatever",
                                  :source_id=> 1
                                  })

      TrafficSpy::Payload.create({:url=>"http://jumpstartlab.com/blog",
                                  :requested_at=>"2013-02-16 21:38:28 -0700",
                                  :responded_in=>54,
                                  :referred_by=>"http://jumpstartlab.com",
                                  :request_type=>"GET",
                                  :parameters=>[],
                                  :event_name=>"socialLogin",
                                  :user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  :resolution_width=>"1920",
                                  :resolution_height=>"1280",
                                  :ip=>"63.29.38.211",
                                  :unique_hash=>"stuff and things",
                                  :source_id=> 1
                                  })


    end

    def test_source_and_payload_setup_work
      assert_equal 1, Source.all.count
      assert_equal 3, Payload.all.count
    end

    def test_url_counts_returns_the_count_of_urls
      source = Source.where(identifier: "jumpstartlab").first

      assert_equal 2, source.url_counts(source)[0][1]
      assert_equal 1, source.url_counts(source)[1][1]
    end

    def test_resolutions_returns_height_and_width
      source = Source.where(identifier: "jumpstartlab").first

      assert_equal "1280", source.resolutions(source).keys[0][0]
      assert_equal "1920", source.resolutions(source).keys[0][1]
    end

    def test_response_times_returns_response_times
      source = Source.where(identifier: "jumpstartlab").first

      assert_equal 45, source.response_times(source)[0][1]
      assert_equal 37, source.response_times(source)[1][1]
    end

    def test_browser_counts_returns_browser_counts
      source = Source.where(identifier: "jumpstartlab").first

      assert_equal "Chrome", source.browser_counts(source)[0][0]
      assert_equal 3, source.browser_counts(source)[0][1]
    end

    def test_os_counts_returns_os_counts
      source = Source.where(identifier: "jumpstartlab").first

      assert_equal "Macintosh", source.os_counts(source)[0][0]
      assert_equal 3, source.os_counts(source)[0][1]
    end
  end
end
