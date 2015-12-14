require_relative '../test_helper'

class UserViewsSingleUrlStats < FeatureTest
  def test_user_views_single_url_stats
    Application.create(identifier: 'jumpstartlab', root_url: "home")
    url = Url.create(path:'blog/1')
    Request.create( url_id: 1, request_hash: '1', application_id: 1,
                    response_time: 10, verb: 'GET', referral: "google",
                    browser: 'chrome', os: 'ios')
    Request.create( url_id: 1, request_hash:'2', application_id: 1,
                    response_time: 20, verb: 'POST', referral: "google",
                    browser: 'chrome', os: 'windows')

    visit '/sources/jumpstartlab/urls/blog/1'

    assert page.has_content? '/blog'

    within("#longest") do
      assert page.has_content?('20')
      assert page.has_content?('ms')
    end

    within("#shortest") do
      assert page.has_content?('10')
      assert page.has_content?('ms')
    end

    within("#average") do
      assert page.has_content?('15')
      assert page.has_content?('ms')
    end

    within("#verbs") do
      assert page.has_content?('GET')
      assert page.has_content?('POST')
    end

    within "#popular_referrers" do
      assert page.has_content?('google')
      assert page.has_content?('times')
    end

    within "#popular_ua" do
      assert page.has_content?('chrome')
      assert page.has_content?('times')
    end
  end

  def test_user_see_message_for_unrequested_url
    Application.create(identifier: 'jumpstartlab', root_url: "home")

    visit '/sources/jumpstartlab/urls/blog/2'

    assert page.has_content?('No documented requests')
  end
end
