# require_relative '../test_helper'
#
# class FakeTest < FeatureTest
#   include PayloadPrep
#
#   def create_testing_environment
#     post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}
#
#     post '/sources/jumpstartlab/data', payload_params1
#     post '/sources/jumpstartlab/data', payload_params2
#     post '/sources/jumpstartlab/data', payload_params3
#
#     visit '/sources/jumpstartlab/urls/blog'
#   end
#
#   def test_again
#     create_testing_environment
#   end
#
#   def test_fake_test
#     save_and_open_page
#   end
#
#   def test_again1
#     create_testing_environment
#   end
#
#   def test_again2
#     create_testing_environment
#   end
#
#   def test_again3
#     create_testing_environment
#   end
#
# end
