ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'pry'

DatabaseCleaner.strategy = :truncation, {except: %w([public.schema.migrations])}
Capybara.app = TrafficSpy::Server


class TestData

  def self.clients
    [{"identifier": "jumpstartlab&rootUrl=http://jumpstartlab.com", "rootUrl":  "http://localhost:9393/sources"},
     {"identifier": "google&rootUrl=http://google.com", "rootUrl":  "http://localhost:9393/sources"},
     {"identifier": "apple&rootUrl=http://apple.com", "rootUrl":  "http://localhost:9393/sources"},
     {"identifier": "microsoft&rootUrl=http://microsoft.com", "rootUrl":  "http://localhost:9393/sources"},
     {"identifier": "palantir&rootUrl=http://palantir.com", "rootUrl":  "http://localhost:9393/sources"},
     {"identifier": "yahoo&rootUrl=http://yahoo.com", "rootUrl":  "http://localhost:9393/sources"},
     {"identifier": "turing&rootUrl=http://turing.io", "rootUrl":  "http://localhost:9393/sources"},
     {"identifier": "facebook&rootUrl=http://facebook.com", "rootUrl":  "http://localhost:9393/sources"}
    ]
  end

  def self.payloads
    [{"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"},
     {"url":"http://apple.com/blog","requestedAt":"2014-02-16 21:38:28 -0700","respondedIn":105,"referredBy":"http://apple.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"640","resolutionHeight":"480","ip":"63.29.38.212"},
     {"url":"http://google.com/about","requestedAt":"2013-01-16 21:38:28 -0700","respondedIn":90,"referredBy":"http://apple.com","requestType":"POST","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"63.29.38.213"},
     {"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 21:38:28 -0700","respondedIn":37,"referredBy":"http://apple.com","requestType":"GET","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"},
     {"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 22:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["what","huh"],"eventName": "beginRegistration","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"500","resolutionHeight":"700","ip":"63.29.38.214"},
     {"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 12:38:28 -0700","respondedIn":200,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Windows%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"},
     {"url":"http://google.com/about","requestedAt":"2013-01-16 24:38:28 -0700","respondedIn":540,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/4.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"63.29.38.213"},
     {"url":"http://yahoo.com/news","requestedAt":"2013-01-13 21:38:28 -0700","respondedIn":123,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"},
     {"url":"http://yahoo.com/news","requestedAt":"2013-01-14 21:38:28 -0700","respondedIn":123,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"}
    ]
  end
end
