class PayloadParser < ActiveRecord::Base

  def self.parse(user, payload)
    user_payload = user.payloads.create({
      :requestedAt      => payload["requestedAt"],
      :respondedIn      => payload["respondedIn"],
      :referredBy       => payload["referredBy"],
      :requestType      => payload["requestType"],
      :parameters       => payload["parameters"],
      :userAgent        => payload["userAgent"],
      :resolutionWidth  => payload["resolutionWidth"],
      :resolutionHeight => payload["resolutionHeight"],
      :ip               => payload["ip"]
    })
    user_payload.urls.create({:page         => payload["url"] })
    user_payload.events.create({:eventName  => payload["eventName"] })

  end




end


