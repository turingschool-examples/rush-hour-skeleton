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

      @source = Source.where(identifier: "jumpstartlab").first
    end

    def test_source_and_payload_setup_work
      assert_equal 1, Source.all.count
      assert_equal 3, Payload.all.count
    end

    def test_url_counts_returns_the_count_of_urls
      assert @source.url_counts(@source).flatten.include?(2)
      assert @source.url_counts(@source).flatten.include?(1)
    end

    def test_resolutions_returns_height_and_width
      assert @source.resolutions(@source).keys.flatten.include?("1280")
      assert @source.resolutions(@source).keys.flatten.include?("1920")
    end

    def test_response_times_returns_response_times
      assert @source.response_times(@source).flatten.include?(45)
      assert @source.response_times(@source).flatten.include?(37)
    end

    def test_browser_counts_returns_browser_counts
      assert @source.browser_counts(@source).flatten.include?("Chrome")
      assert @source.browser_counts(@source).flatten.include?(3)
    end

    def test_os_counts_returns_os_counts
      assert @source.os_counts(@source).flatten.include?("Macintosh")
      assert @source.os_counts(@source).flatten.include?(3)
    end

    def test_url_index_returns_all_unique_urls
      assert @source.url_index(@source).include?("http://jumpstartlab.com/blog")
      assert @source.url_index(@source).include?("http://jumpstartlab.com/about")
    end
  end
end
