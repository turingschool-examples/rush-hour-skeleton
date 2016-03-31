module ParamsChecker
  def change_case(params)
    {:identifier => params['identifier'], :root_url => params['rootUrl']}
  end

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
    elsif Client.exists?(identifier: params[:identifier])
      status 403
      body "identifier already registered"
      false
    else
      status 200
      body "good request"
      true
    end
  end
end
