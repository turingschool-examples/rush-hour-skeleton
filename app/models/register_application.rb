require 'json'

module TrafficSpy
  class RegisterApplication
    def initialize(params)
      @identifier = params[:identifier]
      @root_url = params[:rootUrl]
    end

    def method_name

    end
  end
end
