class ClientParser
  def self.parse(params)
    { identifier: params[:identifier],
      root_url:   params[:rootUrl] }
  end

  def self.create(params)
    parsed_data = parse(params)
    Client.new(parsed_data)
  end
end
