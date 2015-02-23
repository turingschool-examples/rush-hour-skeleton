require './test/test_helper.rb'
require 'pry'

class ApplicationUrlStatsTest < Minitest::Test
  include Rack::Test::Methods
  include Capybara::DSL

  def app
    TrafficSpy::Server
  end

  def setup
    super
    @identifier = Identifier.create(name: 'yahoo', root_url: 'yahoo.com')
    setup_yahoo
    visit '/sources/yahoo'
  end

  def test_the_url_path_pages_exist
    assert_equal '/sources/yahoo', current_path
    visit '/sources/yahoo/urls/weather'
    assert_equal '/sources/yahoo/urls/weather', current_path
  end

  def test_when_i_visit_page_i_can_find_longest_response_time
    visit '/sources/yahoo/urls/weather'
    assert page.has_content?('200')
  end

  def test_when_i_visit_page_i_can_find_shortest_response_time
    visit '/sources/yahoo/urls/weather'
    assert page.has_content?('37')
  end

  def test_when_i_visit_page_i_can_find_the_average_response_time
    visit '/sources/yahoo/urls/weather'
    assert page.has_content?('91')
  end

  def test_when_page_doesnt_exist_i_get_error_message
    visit '/sources/jumpstartlab/urls/sadpath'
    assert page.has_content?('Forbidden')
  end

  def test_when_one_http_verb_has_been_used
    visit '/sources/yahoo/urls/weather'
    assert page.has_content?('GET')
  end

  def test_when_two_http_verbs_have_been_used
    visit '/sources/yahoo/urls/not_news'
    assert page.has_content?('GET')
    assert page.has_content?('POST')
  end

  def test_most_popular_referrers
    visit '/sources/yahoo/urls/weather'
    assert page.has_content?('jumpstart')
  end

  def test_most_popular_user_agent_browser
    visit '/sources/yahoo/urls/weather'
    save_and_open_page
    assert page.has_content?('Chrome')
  end
  def test_most_popular_user_agent_platform
    visit '/sources/yahoo/urls/weather'
    assert page.has_content?('Windows')
  end

  def setup_yahoo
    @payload_1 = 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 21:38:28 -0700","respondedIn":37,"referredBy":"http://apple.com","requestType":"GET","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"}'
    @payload_2 = 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 22:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["what","huh"],"eventName": "beginRegistration","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"500","resolutionHeight":"700","ip":"63.29.38.214"}'
    @payload_3 = 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 12:38:28 -0700","respondedIn":200,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Windows%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"}'
    @payload_4 = 'payload={"url":"http://yahoo.com/not_news","requestedAt":"2013-01-14 21:38:28 -0700","respondedIn":123,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"72.29.38.214"}'
    @payload_5 = 'payload={"url":"http://yahoo.com/not_news","requestedAt":"2015-01-14 21:38:28 -0700","respondedIn":130,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"100.100.38.214"}'
    @payload_6 = 'payload={"url":"http://yahoo.com/chat_room","requestedAt":"2015-01-14 21:38:28 -0700","respondedIn":10,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":["slow"],"eventName": "chatting","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/24.0.1309.0 Safari/537.17","resolutionWidth":"1000","resolutionHeight":"1000","ip":"88.88.88.888"}'
    post '/sources/yahoo/data', @payload_1
    post '/sources/yahoo/data', @payload_2
    post '/sources/yahoo/data', @payload_3
    post '/sources/yahoo/data', @payload_4
    post '/sources/yahoo/data', @payload_5
    post '/sources/yahoo/data', @payload_6
  end

end
