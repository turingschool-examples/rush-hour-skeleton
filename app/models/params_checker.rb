module ParamsChecker
  def check(params)
    if params == nil
      status 401
      body "invalid params"
      false
    elsif params[:identifier] == nil || params[:identifier].delete(" ").length == 0
      status 401
      body "invalid identifier"
      false
    elsif params[:root_url] == nil || params[:root_url].delete(" ").length == 0
      status 401
      body "invalid root_url"
      false

    else
      status 200
      body "good request"
      true
    end
  end
end
