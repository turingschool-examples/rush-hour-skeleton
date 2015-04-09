class ClientParser
  def self.parse(data)
    {
      identifier: data[:identifier],
      root_url: data[:rootUrl]
    }
  end
end
