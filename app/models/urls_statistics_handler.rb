class UrlStatisticsHandler
attr_reader :identifier, :relative, :erb, :message, :path
  def initialize(identifier, relative, path = nil)
    @identifier = identifier
    @relative   = relative
    @path       = path
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
      require 'pry'
      binding.pry
      url          =   urls.find {|url, count| url.relative == relative && url.path == nil}

      if url.nil?
        @message = "The url #{relative}/#{path} does not exist."
        @erb     = :url_error
      else
        @erb     = :urls_index
      end
    end
  end

end
