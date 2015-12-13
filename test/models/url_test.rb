require_relative '../test_helper'

class UrlTest < Minitest::Test

  def url_data
    {
      path: 'http://jumpstartlab.com'
    }
  end

  def test_is_created_with_valid_attributes
    Url.create(url_data)
    assert_equal 'http://jumpstartlab.com', Url.last.path
  end

  def test_is_not_created_without_path
    Url.create(path: nil)

    assert_equal 0, Url.count
  end

  def test_is_not_created_with_duplicated_path
    Url.create(url_data)
    Url.create(url_data)

    assert_equal 1, Url.count
  end

  def test_has_many_requests
    url = Url.create(url_data)
    Request.create(url_id: 1,request_hash: Digest::SHA1.hexdigest("1"))
    Request.create(url_id: 1,request_hash: Digest::SHA1.hexdigest("2"))

    assert_equal 2, url.requests.count
  end

  def test_model_calculations
    url =Url.create(path:'blog')
    Request.create( url_id: 1, request_hash: '1',
                    response_time: 10, verb: 'GET', referral: "google",
                    browser: 'chrome', os: 'ios')
    Request.create( url_id: 1, request_hash:'2',
                    response_time: 20, verb: 'POST', referral: "google",
                    browser: 'chrome', os: 'windows')
    Request.create( url_id: 1, request_hash: '3',
                    response_time: 30, verb: 'GET', referral: "turing",
                    browser: 'chrome', os: 'linux')
    Request.create( url_id: 1, request_hash: '4',
                    response_time: 20, verb: 'GET', referral: "yahoo",
                    browser: 'chrome', os: 'windows')
    Request.create( url_id: 1, request_hash: '5',
                    response_time: 20, verb: 'GET', referral: "bing",
                    browser: 'chrome', os: 'ios')
    Request.create( url_id: 1, request_hash: '6',
                    response_time: 20, verb: 'GET', referral: "yahoo",
                    browser: 'opera', os: 'ios')

    assert_equal 30, url.longest_response_time
    assert_equal 10, url.shortest_response_time
    assert_equal 20, url.average_response_time
    assert_equal "GET, POST", url.verbs
    popular_referrers = [["google", 2], ["yahoo", 2], ["turing", 1]]
    assert_equal popular_referrers, url.popular_referrers
    popular_user_agents = [[["chrome", "windows"], 2], [["chrome", "ios"], 2], [["opera", "ios"], 1]]
    assert_equal popular_user_agents, url.popular_user_agents
  end
end
