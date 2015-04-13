ENV["RACK_ENV"] ||= "test"
require 'simplecov'
SimpleCov.start

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

class FeatureTest < Minitest::Test
  include Capybara::DSL
end

class TestData

  def self.clients
    [ {"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com"},
      {"identifier" => "google", "rootUrl" => "http://google.com"},
      {"identifier" => "apple", "rootUrl" => "http://apple.com"},
      {"identifier" => "microsoft", "rootUrl" => "http://microsoft.com"},
      {"identifier" => "palantir", "rootUrl" => "http://palantir.com"},
      {"identifier" => "yahoo", "rootUrl" => "http://yahoo.com"},
      {"identifier" => "turing", "rootUrl" => "http://turing.io"},
      {"identifier" => "facebook", "rootUrl" => "http://facebook.com"}
    ]
  end

  def self.payloads
    [{"payload" => {"url"=>"http://jumpstartlab.com/blog","requestedAt"=>"2013-02-16 21:38:28 -0700","respondedIn"=>37,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>[],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"1920","resolutionHeight"=>"1280","ip"=>"63.29.38.211"}.to_json},
     {"payload" => {"url"=>"http://apple.com/blog","requestedAt"=>"2014-02-16 21:38:28 -0700","respondedIn"=>105,"referredBy"=>"http://apple.com","requestType"=>"GET","parameters"=>[],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"640","resolutionHeight"=>"480","ip"=>"63.29.38.212"}.to_json},
     {"payload" => {"url"=>"http://google.com/about","requestedAt"=>"2013-01-16 21:38:28 -0700","respondedIn"=>90,"referredBy"=>"http://apple.com","requestType"=>"POST","parameters"=>["what","huh"],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"1920","resolutionHeight"=>"1080","ip"=>"63.29.38.213"}.to_json},
     {"payload" => {"url"=>"http://yahoo.com/weather","requestedAt"=>"2013-01-13 21:38:28 -0700","respondedIn"=>37,"referredBy"=>"http://apple.com","requestType"=>"GET","parameters"=>["what","huh"],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"800","resolutionHeight"=>"600","ip"=>"63.29.38.214"}.to_json},
     {"payload" => {"url"=>"http://yahoo.com/weather","requestedAt"=>"2013-01-13 22:38:28 -0700","respondedIn"=>37,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>["what","huh"],"eventName"=> "beginRegistration","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"500","resolutionHeight"=>"700","ip"=>"63.29.38.214"}.to_json},
     {"payload" => {"url"=>"http://yahoo.com/weather","requestedAt"=>"2013-01-13 12:38:28 -0700","respondedIn"=>200,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>["slow"],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Windows%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"800","resolutionHeight"=>"600","ip"=>"63.29.38.214"}.to_json},
     {"payload" => {"url"=>"http://google.com/about","requestedAt"=>"2013-01-16 24:38:28 -0700","respondedIn"=>540,"referredBy"=>"http://jumpstartlab.com","requestType"=>"POST","parameters"=>["what","huh"],"eventName"=> "socialLogin","userAgent"=>"Mozilla/4.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"1920","resolutionHeight"=>"1080","ip"=>"63.29.38.213"}.to_json},
     {"payload" => {"url"=>"http://yahoo.com/news","requestedAt"=>"2013-01-13 21:38:28 -0700","respondedIn"=>123,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>["slow"],"eventName"=> "beginRegistration","userAgent"=>"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"800","resolutionHeight"=>"600","ip"=>"63.29.38.214"}.to_json},
     {"payload" => {"url"=>"http://yahoo.com/news","requestedAt"=>"2013-01-14 21:38:28 -0700","respondedIn"=>123,"referredBy"=>"http://jumpstartlab.com","requestType"=>"POST","parameters"=>["slow"],"eventName"=> "beginRegistration","userAgent"=>"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"800","resolutionHeight"=>"600","ip"=>"63.29.38.214"}.to_json}
    ]
  end

  def self.feature_tests
    [[{"payload" => {"url"=>"http://jumpstartlab.com/blog","requestedAt"=>"2013-02-16 21:38:28 -0700","respondedIn"=>37,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>[],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"1920","resolutionHeight"=>"1280","ip"=>"63.29.38.211"}.to_json}, "jumpstartlab"],
     [{"payload" => {"url"=>"http://apple.com/blog","requestedAt"=>"2014-02-16 21:38:28 -0700","respondedIn"=>105,"referredBy"=>"http://apple.com","requestType"=>"GET","parameters"=>[],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"640","resolutionHeight"=>"480","ip"=>"63.29.38.212"}.to_json}, "apple"],
     [{"payload" => {"url"=>"http://google.com/about","requestedAt"=>"2013-01-16 21:38:28 -0700","respondedIn"=>90,"referredBy"=>"http://apple.com","requestType"=>"POST","parameters"=>["what","huh"],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"1920","resolutionHeight"=>"1080","ip"=>"63.29.38.213"}.to_json}, "google"],
     [{"payload" => {"url"=>"http://yahoo.com/weather","requestedAt"=>"2013-01-13 21:38:28 -0700","respondedIn"=>37,"referredBy"=>"http://apple.com","requestType"=>"GET","parameters"=>["what","huh"],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 [(]Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"800","resolutionHeight"=>"600","ip"=>"63.29.38.214"}.to_json}, "yahoo"],
     [{"payload" => {"url"=>"http://yahoo.com/weather","requestedAt"=>"2013-01-13 22:38:28 -0700","respondedIn"=>37,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>["what","huh"],"eventName"=> "beginRegistration","userAgent"=>"Mozilla/5.0 [(]Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"500","resolutionHeight"=>"700","ip"=>"63.29.38.214"}.to_json}, "yahoo"],
     [{"payload" => {"url"=>"http://yahoo.com/weather","requestedAt"=>"2013-01-13 12:38:28 -0700","respondedIn"=>200,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>["slow"],"eventName"=> "socialLogin","userAgent"=>"Mozilla/5.0 (Windows%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"800","resolutionHeight"=>"600","ip"=>"63.29.38.214"}.to_json}, "yahoo"],
     [{"payload" => {"url"=>"http://google.com/about","requestedAt"=>"2013-01-16 24:38:28 -0700","respondedIn"=>540,"referredBy"=>"http://jumpstartlab.com","requestType"=>"POST","parameters"=>["what","huh"],"eventName"=> "socialLogin","userAgent"=>"Mozilla/4.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"1920","resolutionHeight"=>"1080","ip"=>"63.29.38.213"}.to_json}, "google"],
     [{"payload" => {"url"=>"http://yahoo.com/news","requestedAt"=>"2013-01-13 21:38:28 -0700","respondedIn"=>123,"referredBy"=>"http://jumpstartlab.com","requestType"=>"GET","parameters"=>["slow"],"eventName"=> "beginRegistration","userAgent"=>"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"800","resolutionHeight"=>"600","ip"=>"63.29.38.214"}.to_json}, "yahoo"],
     [{"payload" => {"url"=>"http://yahoo.com/news","requestedAt"=>"2013-01-14 21:38:28 -0700","respondedIn"=>123,"referredBy"=>"http://jumpstartlab.com","requestType"=>"POST","parameters"=>["slow"],"eventName"=> "beginRegistration","userAgent"=>"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"800","resolutionHeight"=>"600","ip"=>"63.29.38.214"}.to_json}, "yahoo"]
    ]
  end

end

class TestNoData

  def self.clients
    [ {"identifier" => "boogiewoogie", "rootUrl" => "http://boogiewoogie.com"}
    ]
  end

  def self.payloads
    [{"payload" => {"url"=>"http://boogiewoogie.com/blog","requestedAt"=>"2013-02-16 21:38:28 -0700","respondedIn"=>37,"referredBy"=>"http://boogiewoogie.com","requestType"=>"GET","parameters"=>[],"userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth"=>"1920","resolutionHeight"=>"1280","ip"=>"63.29.38.211"}.to_json}
    ]
  end
end
