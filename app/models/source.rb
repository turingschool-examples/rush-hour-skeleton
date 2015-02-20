class Source < ActiveRecord::Base
  validates_presence_of   :identifier
  validates_presence_of   :root_url
  validates_uniqueness_of :identifier

  has_many :payloads

  def simplified_json
    { "identifier" => identifier }.to_json
  end

  def error_response
    errors.full_messages.join ", "
  end
end
