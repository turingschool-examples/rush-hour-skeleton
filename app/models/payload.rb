class Payload < ActiveRecord::Base

  belongs_to :client


  def self.url_requests
    group(:path).order('count_id desc').count('id')
  end

  def self.url_response_times
    group(:path).order('average_responded_in desc').average('responded_in')
  end

  def self.url_hyperlinks
    pluck(:path)
  end
end
