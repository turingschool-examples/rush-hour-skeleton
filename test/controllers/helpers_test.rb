# require_relative '../test_helper'
#
# class HelpersTest < TrafficTest
#   include PayloadPrep
#
#   def setup
#     post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}
#     @user = TrafficSpy::User.find(1)
#   end
#
#   def test_returns_full_linked_path
#     payload_full_path = "http://jumpstartlab.com/blog"
#     extension = "urls"
#     expected = "/sources/jumpstartlab/urls/blog"
#     server = TrafficSpy::.new
#
#     actual_path = server.linked_path(payload_full_path, extension)
#     assert_equal expected, actual_path
#   end
#
# end
