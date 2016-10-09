require_relative '../spec_helper'

RSpec.describe "UserAgentStat" do
  describe "validation" do
    it "is invalid without browser" do
      user_agent_stat = UserAgentStat.create( operating_system: "Windows")

      expect(user_agent_stat).to_not be_valid
    end

    it "is invalid without operating system" do
      user_agent_stat = UserAgentStat.create( browser: "Chrome")

      expect(user_agent_stat).to_not be_valid
    end

    it "is valid with all attributes" do
      user_agent_stat = UserAgentStat.create( operating_system: "Windows", browser: "Chrome")

      expect(user_agent_stat).to be_valid
    end
  end

  describe "uniqueness" do
    it "is invalid if browser/operating system pair is not unique" do
      uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
      uas2 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")

      expect(uas2).to_not be_valid
    end

    it "is valid if browser is unique for the operating system " do
      uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
      uas2 = UserAgentStat.create(operating_system: "Windows", browser: "Opera")

      expect(uas2).to be_valid
    end

    it "is valid if operating system is unique for the browser " do
      uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
      uas2 = UserAgentStat.create(operating_system: "Mac OS", browser: "Chrome")

      expect(uas2).to be_valid
    end
  end

  describe ".breakdown_browsers" do
    it "breaks down all browsers" do
      uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
      uas2 = UserAgentStat.create(operating_system: "Mac OS", browser: "Chrome")
      uas3 = UserAgentStat.create(operating_system: "Mac OS", browser: "Safari")

      payload1 = Payload.create( url_id:             12,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas1.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas2.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             12,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas3.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      expected = {"Chrome"=>2, "Safari"=>1}
      expect(UserAgentStat.breakdown_browsers).to eq(expected)
    end
  end
  
  describe ".breakdown_os" do
    it "breaks down all operating systems" do
      uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
      uas2 = UserAgentStat.create(operating_system: "Mac OS", browser: "Chrome")
      uas3 = UserAgentStat.create(operating_system: "Mac OS", browser: "Safari")

      payload1 = Payload.create( url_id:             12,
                                 responded_in:       40,
                                 requested_at:       "2013-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas1.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload2 = Payload.create( url_id:             12,
                                 responded_in:       30,
                                 requested_at:       "2014-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas2.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      payload3 = Payload.create( url_id:             12,
                                 responded_in:       20,
                                 requested_at:       "2016-02-16",
                                 referral_id:        2,
                                 request_id:         3,
                                 event_id:           4,
                                 user_agent_stat_id: uas3.id,
                                 resolution_id:      6,
                                 visitor_id:         7 )

      expected = {"Mac OS"=>2, "Windows"=>1}
      expect(UserAgentStat.breakdown_os).to eq(expected)
    end
  end
end
