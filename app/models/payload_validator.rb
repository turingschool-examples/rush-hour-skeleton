 class PayloadValidator

  attr_reader :params,
              :user

  def initialize(params, user)
    @params = params
    @user = user
  end

  def create_sha
     sha = Digest::SHA256.hexdigest(params.to_s)
     Sha.new(sha: sha)
  end

  def error
    if params['payload'].nil?
      [400, 'Bad Request - Needs a payload']
    elsif user.nil?
      [403, 'Forbidden - Must have registered identifier']
    elsif create_sha.save
      [200, 'OK']
    else
      [403, 'Forbidden - Must be unique payload']
    end
  end
end