module TrafficSpy
  class Application < ActiveRecord::Base
    has_many :payloads
    has_many :relative_paths, through: :payloads
    has_many :browsers, through: :payloads
    has_many :operating_systems, through: :payloads
    has_many :resolutions, through: :payloads

    validates_presence_of :identifier, :root_url
    validates_uniqueness_of :identifier

    def relative_path_requests
      relative_paths.group(:path).order({count: :desc, path: :asc}).count
    end

    def browser_requests
      browsers.group(:browser_name).order({count: :desc, browser_name: :asc}).count
    end

    def operating_system_requests
      operating_systems.group(:op_system).order({count: :desc, op_system: :asc}).count
    end

    def resolution_requests
      resolutions.group(:width, :height).order({count: :desc, width: :asc}).count
    end

    def average_response_times
      paths = payloads.group(:relative_path).average(:responded_in).map { |rel_path, count| [rel_path.path, count]}
      paths.sort_by{ |_, v| -v }
    end
  end
end
