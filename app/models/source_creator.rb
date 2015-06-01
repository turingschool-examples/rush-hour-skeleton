require_relative "source"
require 'json'

class SourceCreator
  attr_reader :status, :body

  def initialize(params)
    @params        = params
    @source        = Source.new(identifier: @params[:identifier], root_url: @params[:rootUrl])
    @status, @body = result
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
