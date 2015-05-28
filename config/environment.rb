# require your gems
require 'bundler'
Bundler.require

# set the pathname for the root of the app
require 'pathname'
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

# require the controller(s)
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }

# require the model(s)
Dir[APP_ROOT.join('app', 'models', '*.rb')].each { |file| require file }

# require your database configurations
require APP_ROOT.join('config', 'database')

# configure Server settings
module TrafficSpy
  class Server < Sinatra::Base
    set :method_override, true
    set :root, APP_ROOT.to_path
    set :views, File.join(TrafficSpy::Server.root, "app", "views")
    set :public_folder, File.join(TrafficSpy::Server.root, "app", "public")
  end
end
