class ParsePayload

  def parse(params)
    JSON.parse(params[:payload])
  end

end
