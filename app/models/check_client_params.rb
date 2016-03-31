module CheckClientParams

  # def check_identifier(params)
  #   true if params[:identifier].length > 0
  # end
  #
  # def check_root_url(params)
  #   true if params[:root_url].length > 0
  # end
  #
  # def check_something
  #   if check_identifier && check_root_url
  #     200
  #     "yay"
  #   else
  #
  #   end
  # end


  # for both identifier and root_url
  # if its nil
  # if its length after deleting all whitespace is 0
  ## its bad
  # otherwise
  ## it's good
  # check if it's taken

  def change_case(params)
    # take the keys and values out of the hash
    # put into new hash with corrected keys
    new_hash = {}
    new_hash[:identifier] = params['identifier']
    new_hash[:root_url] = params['rootUrl']
    new_hash
  end


  def check(params)
    # binding.pry
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
      body "this identifier already exists"
      false
    else
      status 200
      body "good request"
      true
    end
  end

end
