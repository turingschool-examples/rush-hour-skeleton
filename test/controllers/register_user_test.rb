require './test/test_helper'

module TrafficSpy
  class RegisterSourceTest < Minitest::Test
    def test_register_a_source_with_valid_attributes
      post '/sources', {identifier: "jumpstartlab",
                        rootUrl: "http://jumpstartlab.com"
                       }

      assert_equal 1, Source.count
      assert_equal 200, last_response.status
      assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
    end

    def test_cannot_create_a_source_without_identifier
      post '/sources', {rootUrl: "http://jumpstartlab.com"}

      assert_equal 0, Source.count
      assert_equal 400, last_response.status
      assert_equal "Identifier can't be blank", last_response.body
    end

    def test_cannot_register_a_source_without_root_url
      post '/sources', {identifier: "jumpstartlab"}

      assert_equal 0, Source.count
      assert_equal 400, last_response.status
      assert_equal "Root url can't be blank", last_response.body
    end

    def test_duplicated_identifiers_are_forbidden
      post '/sources', {identifier: "jumpstartlab",
                        rootUrl: "http://jumpstartlab.com"
                       }

      assert_equal 1, Source.count
      assert_equal 200, last_response.status

      post '/sources', {identifier: "jumpstartlab",
                        rootUrl: "http://jumpstartlab.com"
                                        }

      assert_equal 1, Source.count
      assert_equal 403, last_response.status
      assert_equal "Identifier has already been taken", last_response.body
    end
  end
end
