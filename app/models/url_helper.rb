class UrlHelper

  def self.create_url(url, path)
    url + '/urls' + '/' + path
  end


end
