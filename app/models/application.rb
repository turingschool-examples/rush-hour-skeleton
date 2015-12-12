module TrafficSpy
  class Application < ActiveRecord::Base
    has_many :payloads
    has_many :relative_paths, through: :payloads
    has_many :browsers, through: :payloads
    validates_presence_of :identifier, :root_url
    validates_uniqueness_of :identifier

    def relative_path_requests
      relative_paths.group(:path).order({count: :desc, path: :asc}).count
    end

    def browser_requests
      browsers.group(:browser_name).order({count: :desc, browser_name: :asc}).count
    end
  end
end
