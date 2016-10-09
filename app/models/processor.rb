module Processor
extend self

  def clean_data(params)
    {identifier: params[:identifier], root_url: params[:rootUrl]}
  end

end
