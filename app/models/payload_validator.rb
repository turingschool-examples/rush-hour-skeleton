 require 'digest'

 class PayloadValidator
  attr_reader :params,
              :source,
              :status,
              :body

  def initialize(params=nil, source)
    @params = params
    @source = source
  end

  def json_parser
     JSON.parse(@params)
  end

  def browser_parser(string)
    UserAgent.parse(string).browser
  end

  def os_parser(string)
    UserAgent.parse(string).platform
  end

  def create_digest
    Digest::SHA256.hexdigest(json_parser.to_s)
  end

  def error
    if params == nil
      return 400, 'Bad Request - Needs a payload'
    elsif source.nil?
      return 403, 'Forbidden - Must have registered identifier'
    end
  end
end

