require_relative 'spec_helper'

RSpec.describe "Payload" do
  describe "validation" do
    it "is invalid without url" do
      payload = Payload.create( requested_at:       "2013-02-16 21:38:28 -0700",
                                responded_in:       37,
                                referred_by:        "http://jumpstartlab.com",
                                request_type:       "GET",
                                event_name:         "socialLogin",
                                user_agent:         "Mozilla/5.0,",
                                resolution_width:   "1920",
                                resolution_height:  "1280",
                                ip:                 "63.29.38.211" )

      expect(payload).to_not be_valid
    end

    it "is invalid without requested_at" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                responded_in:       37,
                                referred_by:        "http://jumpstartlab.com",
                                request_type:       "GET",
                                event_name:         "socialLogin",
                                user_agent:         "Mozilla/5.0,",
                                resolution_width:   "1920",
                                resolution_height:  "1280",
                                ip:                 "63.29.38.211" )

      expect(payload).to_not be_valid
    end

    it "is invalid without responded_in" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                referred_by:        "http://jumpstartlab.com",
                                request_type:       "GET",
                                event_name:         "socialLogin",
                                user_agent:         "Mozilla/5.0,",
                                resolution_width:   "1920",
                                resolution_height:  "1280",
                                ip:                 "63.29.38.211" )

      expect(payload).to_not be_valid
    end

    it "is invalid without referred_by" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                responded_in:       37,
                                request_type:       "GET",
                                event_name:         "socialLogin",
                                user_agent:         "Mozilla/5.0,",
                                resolution_width:   "1920",
                                resolution_height:  "1280",
                                ip:                 "63.29.38.211" )

      expect(payload).to_not be_valid
    end

    it "is invalid without request_type" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                responded_in:       37,
                                referred_by:        "http://jumpstartlab.com",
                                event_name:         "socialLogin",
                                user_agent:         "Mozilla/5.0,",
                                resolution_width:   "1920",
                                resolution_height:  "1280",
                                ip:                 "63.29.38.211" )

      expect(payload).to_not be_valid
    end

    it "is invalid without event_name" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                responded_in:       37,
                                referred_by:        "http://jumpstartlab.com",
                                request_type:       "GET",
                                user_agent:         "Mozilla/5.0,",
                                resolution_width:   "1920",
                                resolution_height:  "1280",
                                ip:                 "63.29.38.211" )

      expect(payload).to_not be_valid
    end

    it "is invalid without user_agent" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                responded_in:       37,
                                referred_by:        "http://jumpstartlab.com",
                                request_type:       "GET",
                                event_name:         "socialLogin",
                                resolution_width:   "1920",
                                resolution_height:  "1280",
                                ip:                 "63.29.38.211" )

      expect(payload).to_not be_valid
    end

    it "is invalid without resolution_width" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                responded_in:       37,
                                referred_by:        "http://jumpstartlab.com",
                                request_type:       "GET",
                                event_name:         "socialLogin",
                                user_agent:         "Mozilla/5.0,",
                                resolution_height:  "1280",
                                ip:                 "63.29.38.211" )

      expect(payload).to_not be_valid
    end

    it "is invalid without resolution_height" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                responded_in:       37,
                                referred_by:        "http://jumpstartlab.com",
                                request_type:       "GET",
                                event_name:         "socialLogin",
                                user_agent:         "Mozilla/5.0,",
                                resolution_width:   "1920",
                                ip:                 "63.29.38.211" )

      expect(payload).to_not be_valid
    end

    it "is invalid without ip" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                responded_in:       37,
                                referred_by:        "http://jumpstartlab.com",
                                request_type:       "GET",
                                event_name:         "socialLogin",
                                user_agent:         "Mozilla/5.0,",
                                resolution_width:   "1920",
                                resolution_height:  "1280" )

      expect(payload).to_not be_valid
    end

    it "is valid with all atributes" do
      payload = Payload.create( url:                "http://jumpstartlab.com/blog",
                                requested_at:       "2013-02-16 21:38:28 -0700",
                                responded_in:       37,
                                referred_by:        "http://jumpstartlab.com",
                                request_type:       "GET",
                                event_name:         "socialLogin",
                                user_agent:         "Mozilla/5.0,",
                                resolution_width:   "1920",
                                resolution_height:  "1280",
                                ip:                 "63.29.38.211" )

      expect(payload).to be_valid
    end
  end
end
