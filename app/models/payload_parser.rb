class PayloadParser
  attr_accessor :data, :message, :status_code

  def self.validate(data, identifier = {})
    new(data, identifier)
  end

  def initialize(data, identifier = {})
    @identifier = identifier
    if data.present?
      @data = InputConverter.conversion(data)
      @payload = new_payload(@data, @identifier)
    else
      @data = {}
    end
  end

  def status
    if application_duplicate?
      403
    elsif identifier_doesnt_exist?
      403
    elsif valid?
      200
    end
  end

  def body
    if application_duplicate?
      "this is duplicate request"
    elsif identifier_doesnt_exist?
      "application url does not exist"
    elsif valid?
      "success"
    end
  end

  def valid?
    if @payload.nil?
      return false
    else
      @payload.save!
    end
  end

  def application_duplicate?
    !new_payload(@data, @identifier).valid?
  end

  def identifier_doesnt_exist?
    Source.where(identifier: @identifier).count == 0
  end

  # def parse(data)
  #   InputConverter.conversion(JSON.parse(data[:payload]))
  # end

  def new_payload(parsed_params, identifier)
    Payload.new(
    source_id: Source.find_by(identifier: @identifier).id,
    url_id: Url.find_or_create_by(url: parsed_params[:url], relative_path: URI(parsed_params[:url]).path).id,
    requested_at: parsed_params[:requested_at],
    responded_in: parsed_params[:responded_in],
    referred_by_id: Referrer.find_or_create_by(referred_by_url: parsed_params[:referred_by]).id,
    request_type_id: RequestType.find_or_create_by(request_type: parsed_params[:request_type]).id,
    parameters: parsed_params[:parameters],
    event_name_id: EventName.find_or_create_by(event_name: parsed_params[:event_name]).id,
    user_agent_id: TrafficSpy::UserAgent.find_or_create_by(web_browser: parsed_params[:user_agent]).id,
    screen_resolution_id: ScreenResolution.find_or_create_by(resolution_width: parsed_params[:resolution_width], resolution_height: parsed_params[:resolution_height]).id,
    ip: parsed_params[:ip]
    )
  end

end
