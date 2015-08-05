class UrlsStatisticsCalculator
  attr_reader :registration

  def initialize(registration)
    @registration = registration
  end

  def find_longest_response_time
     registration.events.order(responded_in: :desc).first[:responded_in]
  end

  def find_shortest_response_time
    registration.events.order(responded_in: :desc).last[:responded_in]
  end

  def find_average_response_time
    registration.events.average(:responded_in)
  end

end
