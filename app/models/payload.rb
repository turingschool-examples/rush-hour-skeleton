class Payload < ActiveRecord::Base
 #validates :payload, presence: true, uniqueness: true
  validate :check_if_kennys_shit_works

  #def check_if_kennys_shit_works
    #count = 0
    #payload.each do |key, value|
      #count += 1 if value == nil
    #end

    #if count > 8
      #errors.add(:parameters, "bad response")
    #end
  #end
end
