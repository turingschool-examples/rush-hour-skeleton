ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'
require 'database_cleaner'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.include Capybara::DSL

  c.before(:all) do
    DatabaseCleaner.clean
  end
  c.after(:each) do
    DatabaseCleaner.clean
  end
end

def new_client
  Client.create(identifier: "google", root_url: "http://google.com")
end

def new_payload
  client_data = {identifier: "google"}
  parsed_data = PayloadParser.parser('{"url":"http://google.com/about","requestedAt":"2013-01-16 23:38:28 -0700","respondedIn":90,"referredBy":"http://apple.com","requestType":"GET","eventName": "show","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"59.29.38.23"}')
  payload = PayloadBuilder.build(parsed_data, client_data[:identifier])
  payload.save
end

def second_payload
  client_data = {identifier: "google"}
  parsed_data = PayloadParser.parser('{"url":"http://google.com/about","requestedAt":"2013-01-16 22:38:28 -0700","respondedIn":32,"referredBy":"http://apple.com/research","requestType":"GET","eventName": "show","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"59.29.38.21"}')
  payload = PayloadBuilder.build(parsed_data, client_data[:identifier])
  payload.save
end

def third_payload
  client_data = {identifier: "google"}
  parsed_data = PayloadParser.parser('{"url":"http://google.com/about","requestedAt":"2013-01-16 21:38:28 -0700","respondedIn":22,"referredBy":"http://jumpstartlab.com/technology","requestType":"GET","eventName": "socialLogin","userAgent":"Mozilla/4.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"63.29.38.213"}')
  payload = PayloadBuilder.build(parsed_data, client_data[:identifier])
  payload.save
end

def fourth_payload
  client_data = {identifier: "google"}
  parsed_data = PayloadParser.parser('{"url":"http://google.com/search","requestedAt":"2013-01-16 20:38:28 -0700","respondedIn":55,"referredBy":"http://jumpstartlab.com/technology","requestType":"GET","eventName": "socialLogin","userAgent":"Mozilla/4.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"63.29.38.213"}')
  payload = PayloadBuilder.build(parsed_data, client_data[:identifier])
  payload.save
end

def fifth_payload
  client_data = {identifier: "google"}
  parsed_data = PayloadParser.parser('{"url":"http://google.com/about","requestedAt":"2013-01-16 21:38:28 -0700","respondedIn":21,"referredBy":"http://google.com","requestType":"GET","eventName": "show","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"420","resolutionHeight":"700","ip":"59.29.38.222"}')
  payload = PayloadBuilder.build(parsed_data, client_data[:identifier])
  payload.save
end

def build_payloads_with_real_data
  new_payload
  second_payload
  third_payload
  fourth_payload
  fifth_payload
end

def build_several_payloads
  Payload.create( url_id:             12,
                  responded_in:       20,
                  requested_at:       "2013-02-16",
                  referral_id:        2,
                  request_id:         3,
                  event_id:           4,
                  user_agent_stat_id: 5,
                  resolution_id:      6,
                  visitor_id:         7,
                  client_id:          4 )

  Payload.create( url_id:             12,
                  responded_in:       30,
                  requested_at:       "2014-02-16",
                  referral_id:        2,
                  request_id:         3,
                  event_id:           4,
                  user_agent_stat_id: 5,
                  resolution_id:      6,
                  visitor_id:         7,
                  client_id:          4 )

  Payload.create( url_id:             12,
                  responded_in:       40,
                  requested_at:       "2016-02-16",
                  referral_id:        2,
                  request_id:         3,
                  event_id:           4,
                  user_agent_stat_id: 5,
                  resolution_id:      6,
                  visitor_id:         7,
                  client_id:          4 )
end

def build_several_requests
  Request.create(request_type: "GET")
  Request.create(request_type: "GET")
  Request.create(request_type: "GET")
  Request.create(request_type: "PUT")
  Request.create(request_type: "PUT")
  Request.create(request_type: "POST")
  Request.create(request_type: "PATCH")
  Request.create(request_type: "DELETE")
end

def build_linked_resolutions_and_payloads
  resolution1 = Resolution.create(height: "5", width: "10")
  resolution2 = Resolution.create(height: "5", width: "6")
  resolution3 = Resolution.create(height: "4", width: "6")

  Payload.create( url_id:             12,
                  responded_in:       40,
                  requested_at:       "2013-02-16",
                  referral_id:        2,
                  request_id:         3,
                  event_id:           4,
                  user_agent_stat_id: 5,
                  resolution_id:      resolution1.id,
                  visitor_id:         7 )

  Payload.create( url_id:             12,
                  responded_in:       30,
                  requested_at:       "2014-02-16",
                  referral_id:        2,
                  request_id:         3,
                  event_id:           4,
                  user_agent_stat_id: 5,
                  resolution_id:      resolution2.id,
                  visitor_id:         7 )

  Payload.create( url_id:             12,
                  responded_in:       20,
                  requested_at:       "2016-02-16",
                  referral_id:        2,
                  request_id:         3,
                  event_id:           4,
                  user_agent_stat_id: 5,
                  resolution_id:      resolution3.id,
                  visitor_id:         7 )
end

def build_payloads_linked_with_urls(url1, url2)
  payload1 = Payload.create(  url_id:            url1.id,
                              responded_in:       37,
                              requested_at:       "2013-02-16 21:38:28 -0700",
                              referral_id:        2,
                              request_id:         3,
                              event_id:           4,
                              user_agent_stat_id: 5,
                              resolution_id:      6,
                              visitor_id:         7,
                              client_id:          4 )

  payload2 = Payload.create(  url_id:            url1.id,
                              responded_in:       38,
                              requested_at:       "2014-02-16 21:38:28 -0700",
                              referral_id:        2,
                              request_id:         3,
                              event_id:           4,
                              user_agent_stat_id: 5,
                              resolution_id:      6,
                              visitor_id:         7,
                              client_id:          4 )

  payload3 = Payload.create(  url_id:            url2.id,
                              responded_in:       39,
                              requested_at:       "2015-02-16 21:38:28 -0700",
                              referral_id:        2,
                              request_id:         3,
                              event_id:           4,
                              user_agent_stat_id: 5,
                              resolution_id:      6,
                              visitor_id:         7,
                              client_id:          4 )

end

def build_linked_requests_and_payloads_for_url(url)
  request_1 = Request.create(request_type: "GET")
  request_2 = Request.create(request_type: "PUT")
  request_3 = Request.create(request_type: "POST")

  payload1 = Payload.create( url_id:             url.id,
                             responded_in:       40,
                             requested_at:       "2013-02-16",
                             referral_id:        1,
                             request_id:         request_1.id,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )

  payload2 = Payload.create( url_id:             url.id,
                             responded_in:       30,
                             requested_at:       "2014-02-16",
                             referral_id:        1,
                             request_id:         request_2.id,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )

  payload3 = Payload.create( url_id:             url.id,
                             responded_in:       20,
                             requested_at:       "2016-02-16",
                             referral_id:        1,
                             request_id:         request_3.id,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )

  payload4 = Payload.create( url_id:             url.id,
                             responded_in:       40,
                             requested_at:       "2013-02-16",
                             referral_id:        1,
                             request_id:         request_1.id,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )
end

def build_linked_referrals_and_payloads_for_url(url)
  ref1  = Referral.create(source: "http://google.com")
  ref2  = Referral.create(source: "http://coursereport.com")
  ref3  = Referral.create(source: "http://turing.io")

  payload1 = Payload.create( url_id:             url.id,
                             responded_in:       40,
                             requested_at:       "2013-02-16",
                             referral_id:        ref1.id,
                             request_id:         3,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )

  payload2 = Payload.create( url_id:             url.id,
                             responded_in:       30,
                             requested_at:       "2014-02-16",
                             referral_id:        ref2.id,
                             request_id:         3,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )

  payload3 = Payload.create( url_id:             url.id,
                             responded_in:       20,
                             requested_at:       "2016-02-16",
                             referral_id:        ref3.id,
                             request_id:         3,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )

  payload4 = Payload.create( url_id:             url.id,
                             responded_in:       40,
                             requested_at:       "2013-02-16",
                             referral_id:        ref2.id,
                             request_id:         3,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )

  payload5 = Payload.create( url_id:             url.id,
                             responded_in:       30,
                             requested_at:       "2014-02-16",
                             referral_id:        ref1.id,
                             request_id:         3,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )

  payload6 = Payload.create( url_id:             url.id,
                             responded_in:       20,
                             requested_at:       "2016-02-16",
                             referral_id:        ref2.id,
                             request_id:         3,
                             event_id:           4,
                             user_agent_stat_id: 5,
                             resolution_id:      6,
                             visitor_id:         7,
                             client_id:          4 )
end

def build_linked_user_agent_stats_and_payloads_for_url(url)
  uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
  uas2 = UserAgentStat.create(operating_system: "Mac OS",  browser: "Chrome")
  uas3 = UserAgentStat.create(operating_system: "Mac OS",  browser: "Safari")

  payload1 = Payload.create(url_id:             url.id,
                            responded_in:       40,
                            requested_at:       "2013-02-16",
                            referral_id:        2,
                            request_id:         3,
                            event_id:           4,
                            user_agent_stat_id: uas1.id,
                            resolution_id:      6,
                            visitor_id:         7,
                            client_id:          4 )

  payload2 = Payload.create(url_id:             url.id,
                            responded_in:       30,
                            requested_at:       "2014-02-16",
                            referral_id:        2,
                            request_id:         3,
                            event_id:           4,
                            user_agent_stat_id: uas2.id,
                            resolution_id:      6,
                            visitor_id:         7,
                            client_id:          4 )

  payload3 = Payload.create(url_id:             url.id,
                            responded_in:       20,
                            requested_at:       "2016-02-16",
                            referral_id:        2,
                            request_id:         3,
                            event_id:           4,
                            user_agent_stat_id: uas3.id,
                            resolution_id:      6,
                            visitor_id:         7,
                            client_id:          4 )

  payload4 = Payload.create(url_id:             url.id,
                            responded_in:       40,
                            requested_at:       "2013-02-16",
                            referral_id:        2,
                            request_id:         3,
                            event_id:           4,
                            user_agent_stat_id: uas2.id,
                            resolution_id:      6,
                            visitor_id:         7,
                            client_id:          4 )

  payload5 = Payload.create(url_id:             url.id,
                            responded_in:       30,
                            requested_at:       "2014-02-16",
                            referral_id:        2,
                            request_id:         3,
                            event_id:           4,
                            user_agent_stat_id: uas1.id,
                            resolution_id:      6,
                            visitor_id:         7,
                            client_id:          4 )

  payload6 = Payload.create(url_id:             url.id,
                            responded_in:       20,
                            requested_at:       "2016-02-16",
                            referral_id:        2,
                            request_id:         3,
                            event_id:           4,
                            user_agent_stat_id: uas2.id,
                            resolution_id:      6,
                            visitor_id:         7,
                            client_id:          4 )
end

def build_linked_user_agent_stats_and_payloads
  uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
  uas2 = UserAgentStat.create(operating_system: "Mac OS", browser: "Chrome")
  uas3 = UserAgentStat.create(operating_system: "Mac OS", browser: "Safari")

  payload1 = Payload.create( url_id:             12,
                             responded_in:       40,
                             requested_at:       "2013-02-16",
                             referral_id:        2,
                             request_id:         3,
                             event_id:           4,
                             user_agent_stat_id: uas1.id,
                             resolution_id:      6,
                             visitor_id:         7 )

  payload2 = Payload.create( url_id:             12,
                             responded_in:       30,
                             requested_at:       "2014-02-16",
                             referral_id:        2,
                             request_id:         3,
                             event_id:           4,
                             user_agent_stat_id: uas2.id,
                             resolution_id:      6,
                             visitor_id:         7 )

  payload3 = Payload.create( url_id:             12,
                             responded_in:       20,
                             requested_at:       "2016-02-16",
                             referral_id:        2,
                             request_id:         3,
                             event_id:           4,
                             user_agent_stat_id: uas3.id,
                             resolution_id:      6,
                             visitor_id:         7 )
end
