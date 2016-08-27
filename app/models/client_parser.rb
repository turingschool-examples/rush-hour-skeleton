class ClientParser
  def self.parse(params)
    { identifier: params[:identifier],
      root_url:   params[:rootUrl] }
  end

  def self.create(params)
    Client.create(parse(params))
  end
end
