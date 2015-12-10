require_relative '../test_helper'

class PayloadTest < TrafficTest
  include PayloadPrep

  def setup
    setup_model_testing_environment
    @user = TrafficSpy::User.find(1)
  end

  def test_url_popularity
    expected_result = {"http://jumpstartlab.com/blog"=>2, "http://jumpstartlab.com/weather"=>1}
    assert_equal expected_result, @user.payloads.url_popularity
  end

end
