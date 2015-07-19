class AppDataHandler

  attr_reader :registration, :identifier, :message, :erb

  def initialize(identifier)
    @identifier = identifier
    @registration = Registration.find_by(:identifier => identifier)
    check_registration
  end

  def check_registration
    # if registration.nil?
    @message = "The #{identifier} identifier does not exist"
    @erb     =  :identifier_error

    # end
  end


  # if registration.nil?
  #   @message = "The #{identifier} identifier does not exist"
  #   erb :identifier_error
  # else
  def url_stats
    registration.urls.map do |key, value|
      if !key.nil?
        [value, key[:url]]
      end
    end.compact.sort.reverse
  end


  def browser_stats
    registration.browsers.map do |key, value|
      if !key.nil?
        [value, key[:name]]
      end
    end.compact.sort.reverse
  end

  def os_stats
    registration.operating_systems.map do |key, value|
      if !key.nil?
        [value, key[:name]]
      end
    end.compact.sort.reverse
  end

  def resolution_stats
    registration.screen_resolutions.map do |key, value|
      if !key.nil?
        [value, key[:width],key[:height]]
      end
    end.compact.sort.reverse
  end

  def response_times
    registration.events.average(:responded_in)
    # require 'pry'; binding.pry
    # @long_response_times = registration.events.maximum(:responded_in)
    # @short_response_times = registration.events.minimum(:responded_in)
  end

  def link_list
    @links = registration.urls.map do |key, value|
      if !key.nil?
        [key[:url]]
      end
    end.compact
  end

  def link_paths
    @links.map do |link|
      URI(link.join).path
    end
  end
end
