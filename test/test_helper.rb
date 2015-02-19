ENV["RACK_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)
require "minitest/autorun"
require "minitest/pride"
require "capybara"

Capybara.app = TrafficSpy::Server

require "database_cleaner"
<<<<<<< HEAD
DatabaseCleaner.strategy = :truncation, { except: %w[public.schema_migrations] }
=======
DatabaseCleaner.strategy = :truncation, { :except => %w[public.schema_migrations]}
>>>>>>> 8f47a150a1f92a41dac4472091fc018005408d20
