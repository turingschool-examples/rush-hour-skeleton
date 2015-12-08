module TrafficSpy
  class RegisterApplication
    attr_reader :identifier, :root_url, :application

    def initialize(params)
      @identifier = params[:identifier]
      @root_url = params[:rootUrl]
      @application = TrafficSpy::Application.new(identifier: @identifier, root_url: @root_url)
    end

    def save
      if valid_params?
        [200, { identifier: identifier }.to_json]
      elsif error_message == "Identifier has already been taken"
        [403, error_message]
      else
        [400, error_message]
      end
    end

    def error_message
      application.errors.full_messages.first
    end

    def valid_params?
      application.save
    end
  end
end
