class TrafficSpyApp < Sinatra::Base

  post '/sources' do
    source = Source.new(params[])

end
