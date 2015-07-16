class HashParser
  def self.parse(params)
    params[:identifier] = params["identifier"]
    params[:root_url] = params["rootUrl"]
    params.delete("rootUrl")
    params.delete("identifier")
    params
  end
end