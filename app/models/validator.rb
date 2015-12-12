module TrafficSpy
  class Validator < ActiveRecord::Base

    def self.indentifier_exists?(id)
      TrafficSpy::User.find_by(identifier: id)
    end


  end
end

#
# @user = TrafficSpy::User.find_by(identifier: id)