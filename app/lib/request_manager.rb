class RequestManager
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