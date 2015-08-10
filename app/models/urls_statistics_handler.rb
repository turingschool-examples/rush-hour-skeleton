class UrlStatisticsHandler
  attr_reader :identifier, :path, :erb, :message, :url

  def initialize(identifier, path)
    @identifier = identifier
    @path   = path
    call
    self
  end

  def call
    registration = Registration.find_by(:identifier => identifier)
    check_registration(registration)
  end

  def check_registration(registration)
    if registration.nil?
      @message = "The #{identifier} identifier does not exist"
      @erb     =  :identifier_error
    else
      @url      = find_url(registration)
      check_for_nil_url(url)
    end
  end

  def check_for_nil_url(url)
    if url.nil?
      @message = "The url #{path} does not exist."
      @erb     = :url_error
    else
      @message = "You're all good!"
      @erb     = :urls_index
    end

  end

  def find_url(registration)
    urls         = registration.urls.select{|url, count| url != nil}
    urls.find {|url, count| url.path == "/#{path}" }.first
  end

end
