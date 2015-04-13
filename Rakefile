require "bundler"
Bundler.require

require "sinatra/activerecord/rake"
require 'rake/testtask'
require 'reek'

task :test do
  Dir.glob('./test/**/*_test.rb') { |file| require file }
end

task :capy_test do
  Dir.glob('./test/features/*_test.rb') { |file| require file }
end

task :delete_cap do 
  Dir.glob('capybara*') do |file| 
    rm file 
  end
end  

namespace :no_feature_test do 

  desc "Test the models"
  task :model_test do 
    Dir.glob('./test/models/*_test.rb') { |file| require file }
  end

  desc "Test the controllers"
  task :controller_test do 
    Dir.glob('./test/controllers/*_test.rb') { |file| require file }
  end

  "Check models and controllers tests"
  task :all => [:model_test, :controller_test]
end

namespace :sanitation do
  desc "Check line lengths & whitespace with Cane"
  task :lines do
    puts ""
    puts "== using cane to check line length =="
    system("cane --no-abc --style-glob 'app/**/*.rb' --no-doc")
    puts "== done checking line length =="
    puts ""
  end

  desc "Check method length with Reek"
  task :methods do
    puts ""
    puts "== using reek to check method length =="
    system("reek -n app/**/*.rb 2>&1 | grep -v ' 0 warnings'")
    puts "== done checking method length =="
    puts ""
  end

  desc "Check both line length and method length"
  task :all => [:lines, :methods]
end
