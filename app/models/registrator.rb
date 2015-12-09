class Registrator
  attr_reader :status, :response

  def initialize(params)
    application = Application.new(identifier: params[:identifier],
                                  root_url: params[:rootUrl])
    if application.identifier.nil?
      @status = 400
      @response = "Missing identifier."
    elsif application.root_url.nil?
      @status = 400
      @response ="Missing rootUrl."
    elsif application.save
      @status = 200
      @response ="Application created. #{{identifier: params[:identifier]}.to_json}"
    else
      @status = 403
      @response ="Identifier already exists."
    end
  end
end

class Registrator_Req
  attr_reader :status, :response

  def initialize(params)
    if params[:payload].nil?
      @status = 400
      @response =  "Missing payload."
    else params[:payload]
      request = Request.new(request_hash: Digest::SHA1.hexdigest(params[:payload]))
      if Application.exists?(identifier: params[:id])
        if request.save
          @status = 200
          @response = "Success."
        else
          @status = 400
          @response = "Duplicate entry."
        end
      else
        @status = 403
        @response = "Application not registered."
      end
    end
  end
end
