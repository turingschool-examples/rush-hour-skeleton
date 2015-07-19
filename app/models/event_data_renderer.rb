class EventDataRenderer
  attr_reader :identifier,
              :event_name,
              :requests_per_hour

  def initialize(identifier, event_name, site, event)
    @identifier = identifier
    @event_name = event_name
    @site = site
    @event = event
    @requests_per_hour = get_requests_per_hour
  end

  def get_requests_per_hour
    events = @site.payloads.where(:event_id => @event.id)
    hours = events.map { |event| Time.parse(event[:requested_at]).hour }
    hour_count = hours.group_by{ |h| h }
    requests_per_hour = {
      0 => 0,
      1 => 0,
      2 => 0,
      3 => 0,
      4 => 0,
      5 => 0,
      6 => 0,
      7 => 0,
      8 => 0,
      9 => 0,
      10 => 0,
      11 => 0,
      12 => 0,
      13 => 0,
      14 => 0,
      15 => 0,
      16 => 0,
      17 => 0,
      18 => 0,
      19 => 0,
      20 => 0,
      21 => 0,
      22 => 0,
      23 => 0
    }

    requests_per_hour.map do |k, v|
      if hour_count[k] != nil
        requests_per_hour[k] = hour_count[k].size
      end
    end

    requests_per_hour
  end

end