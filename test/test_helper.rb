ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
Capybara.app = RushHour::Server
DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelpers

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_payloads(num)
    analyzer = PayloadAnalyzer.new
    num.times { |index| analyzer.parse(random_payloads[index]) }
  end
  # 
  # def create_clients(num)
  #   analyzer = ClientAnalyzer.new
  #   num.times { |index| analyzer.parse({identifier: "thing#{index}", root_url: "www.another_thing.com#{index}"})}
  # end

  def random_payloads
    [
      {"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-17 10:34:18 -0700","respondedIn":67,"referredBy":"http://google.com","requestType":"GET","parameters":[],"eventName": "ChickenLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"},
      {"url":"http://jumpstartlab.com/about","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"},
      {"url":"http://google.com/about","requestedAt":"2013-01-16 21:38:28 -0700","respondedIn":90,"referredBy":"http://apple.com","requestType":"POST","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (compatible; MSIE 9.0; AOL 9.7; AOLBuild 4343.19; Windows NT 6.1; WOW64; Trident/5.0; FunWebProducts)","resolutionWidth":"1920","resolutionHeight":"1080","ip":"63.29.38.213"},
      {"url":"http://jumpstartlab.com/about","requestedAt":"2013-02-17 10:34:18 -0700","respondedIn":67,"referredBy":"http://google.com","requestType":"POST","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"},
      {"url":"http://jumpstartlab.com/about","requestedAt":"2013-02-17 10:34:18 -0700","respondedIn":67,"referredBy":"http://google.com","requestType":"POST","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (compatible; MSIE 9.0; AOL 9.7; AOLBuild 4343.19; Windows NT 6.1; WOW64; Trident/5.0; FunWebProducts)","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}
    ]
  end

end
