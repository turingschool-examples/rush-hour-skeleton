require 'digest'

module Unique
  def create_sha(params)
    Digest::SHA1.hexdigest params.to_s
  end

  def sha_exists?(params)
    
  end
end
