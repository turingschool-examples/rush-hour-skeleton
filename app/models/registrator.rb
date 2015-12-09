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
