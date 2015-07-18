class UrlStatisticsHandler
attr_reader :identifier, :path, :erb, :message
  def initialize(identifier, path)
    @identifier = identifier
    @path   = path
    call
    self
  end

  def call
    registration = Registration.find_by(:identifier => identifier)
    if registration.nil?
      @message = "The #{identifier} identifier does not exist"
      @erb     =  :identifier_error
    else
      urls         = registration.urls.select{|url, count| url != nil}
      # url          =   urls.find {|url, count| url.path == path }

      if url.nil?
        @message = "The url #{path} does not exist."
        @erb     = :url_error
      else
        @erb     = :urls_index
      end
    end
  end

end
