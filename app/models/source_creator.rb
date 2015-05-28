require_relative "source"

class SourceCreator
  attr_reader :status, :body

  def result(params)
    source = Source.new(identifier: params[:identifier], root_url: params[:rootUrl])
    if source.save
      @status = 200
      @body = "{'identifier':'jumpstartlab'}"
    elsif Source.all.any? { |s| s.identifier == source.identifier }
      @status = 403
      @body = "Identifier already exists"
    else
      @status = 400
      @body = source.errors.full_messages.join
    end
  end
end
