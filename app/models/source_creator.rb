require_relative "source"
require 'json'

class SourceCreator
  def initialize(params)
    @params = params
    @source = Source.new(identifier: @params[:identifier], root_url: @params[:rootUrl])
  end

  def status
    result[0]
  end

  def body
    result[1]
  end

  def registered?
    Source.exists?(identifier: @source.identifier)
  end

  def result
    if @source.save
      [200, {identifier: @params[:identifier]}.to_json]
    elsif registered?
      [403, "Identifier already exists"]
    else
      [400, @source.errors.full_messages.join]
    end
  end
end
