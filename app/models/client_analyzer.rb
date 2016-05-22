class ClientAnalyzer

  def initialize(params)
    @params = params
  end

  def parse_client_params
    {identifier: @params[:identifier], root_url: @params[:rootUrl]}
  end


end
