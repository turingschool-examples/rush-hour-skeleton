class Registrator
  attr_reader :status, :response, :application

  def initialize(params)
    @application = Application.new(identifier: params[:identifier],
                                  root_url: params[:rootUrl])
    @status = code[scenario(params)]
    @response = response_maker(params)[scenario(params)]
  end

  def scenario(params)
    stat = "duplicate"
    stat = "id_missing" if application.identifier.nil? && application.root_url
    stat = "root_missing" if application.root_url.nil? && application.identifier
    stat = "success" if application.save
    stat
  end

  def code
    { "duplicate" =>    403,
      "id_missing" =>   400,
      "root_missing" => 400,
      "success" =>      200
    }
  end

  def response_maker(params)
    { "duplicate" =>    "Identifier already exists.",
      "id_missing" =>   "Missing identifier.",
      "root_missing" => "Missing rootUrl.",
      "success" =>      "Application created. #{{identifier:params[:identifier]}.to_json}"
    }
  end
end

# class Registrator
#   attr_reader :status, :response, :application
#
#   def initialize(params)
#     application = Application.new(identifier: params[:identifier],
#                                   root_url: params[:rootUrl])
#     if application.identifier.nil?
#       @status = 400
#       @response = "Missing identifier."
#     elsif application.root_url.nil?
#       @status = 400
#       @response ="Missing rootUrl."
#     elsif application.save
#       @status = 200
#       @response ="Application created. #{{identifier: params[:identifier]}.to_json}"
#     else
#       @status = 403
#       @response ="Identifier already exists."
#     end
#   end
# end
#


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
