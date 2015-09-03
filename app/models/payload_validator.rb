 class PayloadValidator
  attr_reader :params,
              :source

  def initialize(params, source)
    @params = params
    @source = source
  end

  def create_digest
     digest = Digest::SHA256.hexdigest(params.to_s)
     Payload.new(digest: digest, source_id: source.id)
  end

  def error
    if params['payload'].nil?
      [400, 'Bad Request - Needs a payload']
    elsif source.nil?
      [403, 'Forbidden - Must have registered identifier']
    elsif create_digest.save
      [200, 'OK']
    else
      [403, 'Forbidden - Must be unique payload']
    end
  end
end
