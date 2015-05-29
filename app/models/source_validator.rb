module TrafficSpy
  class SourceValidator
    attr_reader :message, :status

    def validate(params)
      source = Source.new(root_url: params[:rootUrl], identifier: params[:identifier])
      if source.save
        @message = {identifier: source.identifier}.to_json
      elsif source.errors.full_messages.include?("Identifier has already been taken")
        @status = 403
        @message = "identifier already exists"
      else
        @status =  400
        @message = "missing a parameter ya doofus"
      end
    end
  end
end
