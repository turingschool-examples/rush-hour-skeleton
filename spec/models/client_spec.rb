require_relative '../spec_helper'

describe Client do
  it "is invalid with same identifier" do
    c1 = Client.create(identifier: "bradanthony", root_url: "turing")
    c2 = Client.create(identifier: "bradanthony", root_url: "turing")

    expect(c2).to_not be_valid
    expect(c1).to be_valid
  end

  it "can return associated agent info" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    a = Agent.create(browser: "Chrome", operating_system: "OSX")
    pl = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 4,
                   agent_id: a.id,
                   resolution_id: 6,
                   ip_id: 7,
                   url_id: 3,
                   client_id: c.id)

    expect(c.agent.first.class).to eq(Agent)
    expect(c.agent.first.browser).to eq("Chrome")
  end

  it "can return associated event info" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    e = Event.create(event_name: "social_login")
    pl = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: e.id,
                   agent_id: 5,
                   resolution_id: 6,
                   ip_id: 7,
                   url_id: 3,
                   client_id: c.id)

    expect(c.event.first.class).to eq(Event)
    expect(c.event.first.event_name).to eq("social_login")
  end

  it "can return associated ip info" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    i = Ip.create(address: "192.168.1.0")
    pl = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 2,
                   agent_id: 5,
                   resolution_id: 6,
                   ip_id: i.id,
                   url_id: 3,
                   client_id: c.id)

    expect(c.ip.first.class).to eq(Ip)
    expect(c.ip.first.address).to eq("192.168.1.0")
  end

  it "can return associated referred_by info" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    rb = ReferredBy.create(root_url: "google.com", path: "/images")
    pl = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: rb.id,
                   request_type_id: 3,
                   event_id: 2,
                   agent_id: 5,
                   resolution_id: 6,
                   ip_id: 5,
                   url_id: 3,
                   client_id: c.id)

    expect(c.referred_by.first.class).to eq(ReferredBy)
    expect(c.referred_by.first.root_url).to eq("google.com")
    expect(c.referred_by.find(rb.id).class).to eq(ReferredBy)
  end

  it "can return associated request_type info" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    rt = RequestType.create(http_verb: "GET")
    pl = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: rt.id,
                   event_id: 2,
                   agent_id: 5,
                   resolution_id: 6,
                   ip_id: 2,
                   url_id: 3,
                   client_id: c.id)

    expect(c.request_type.first.class).to eq(RequestType)
    expect(c.request_type.find(rt.id).class).to eq(RequestType)
    expect(c.request_type.find(rt.id).http_verb).to eq("GET")
  end

  it "can return associated resolution info" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    r = Resolution.create(height: "10", width: "20")
    pl = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 2,
                   agent_id: 5,
                   resolution_id: r.id,
                   ip_id: 2,
                   url_id: 3,
                   client_id: c.id)

    expect(c.resolution.first.class).to eq(Resolution)
    expect(c.resolution.find(r.id).class).to eq(Resolution)
    expect(c.resolution.find(r.id).height).to eq("10")
    expect(c.resolution.find(r.id).width).to eq("20")
  end

  it "can return associated url info" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    u = Url.create(root_url: "google.com", path: "/images")
    pl = Payload.create(requested_at: "test",
                   responded_in: 12,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 2,
                   agent_id: 5,
                   resolution_id: 4,
                   ip_id: 2,
                   url_id: u.id,
                   client_id: c.id)

    expect(c.url.first.class).to eq(Url)
    expect(c.url.find(u.id).class).to eq(Url)
    expect(c.url.find(u.id).root_url).to eq("google.com")
    expect(c.url.find(u.id).path).to eq("/images")
  end

  it "can return average response time" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    c2 = Client.create(identifier: "Anthony", root_url: "turing")
    pl = Payload.create(requested_at: "test",
                   responded_in: 5,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 2,
                   agent_id: 5,
                   resolution_id: 4,
                   ip_id: 2,
                   url_id: 1,
                   client_id: c.id)

    pl = Payload.create(requested_at: "test",
                    responded_in: 10,
                    referred_by_id: 2,
                    request_type_id: 3,
                    event_id: 2,
                    agent_id: 5,
                    resolution_id: 4,
                    ip_id: 2,
                    url_id: 1,
                    client_id: c.id)

      pl = Payload.create(requested_at: "test",
                     responded_in: 15,
                     referred_by_id: 2,
                     request_type_id: 3,
                     event_id: 2,
                     agent_id: 5,
                     resolution_id: 4,
                     ip_id: 2,
                     url_id: 1,
                     client_id: c2.id)

      expect(c.average_response_time).to eq(7.5)
  end

  it "can return max response time" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    c2 = Client.create(identifier: "Anthony", root_url: "turing")
    pl = Payload.create(requested_at: "test",
                   responded_in: 5,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 2,
                   agent_id: 5,
                   resolution_id: 4,
                   ip_id: 2,
                   url_id: 1,
                   client_id: c.id)

    pl = Payload.create(requested_at: "test",
                    responded_in: 10,
                    referred_by_id: 2,
                    request_type_id: 3,
                    event_id: 2,
                    agent_id: 5,
                    resolution_id: 4,
                    ip_id: 2,
                    url_id: 1,
                    client_id: c.id)

      pl = Payload.create(requested_at: "test",
                     responded_in: 15,
                     referred_by_id: 2,
                     request_type_id: 3,
                     event_id: 2,
                     agent_id: 5,
                     resolution_id: 4,
                     ip_id: 2,
                     url_id: 1,
                     client_id: c2.id)

      expect(c.max_response_time).to eq(10)
  end

  it "can return min response time" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    c2 = Client.create(identifier: "Anthony", root_url: "turing")
    pl = Payload.create(requested_at: "test",
                   responded_in: 5,
                   referred_by_id: 2,
                   request_type_id: 3,
                   event_id: 2,
                   agent_id: 5,
                   resolution_id: 4,
                   ip_id: 2,
                   url_id: 1,
                   client_id: c.id)

    pl = Payload.create(requested_at: "test",
                    responded_in: 10,
                    referred_by_id: 2,
                    request_type_id: 3,
                    event_id: 2,
                    agent_id: 5,
                    resolution_id: 4,
                    ip_id: 2,
                    url_id: 1,
                    client_id: c.id)

      pl = Payload.create(requested_at: "test",
                     responded_in: 15,
                     referred_by_id: 2,
                     request_type_id: 3,
                     event_id: 2,
                     agent_id: 5,
                     resolution_id: 4,
                     ip_id: 2,
                     url_id: 1,
                     client_id: c2.id)

      expect(c.min_response_time).to eq(5)
    end

    it "can return most frequent request type" do
      c = Client.create(identifier: "Bradanthony", root_url: "turing")
      c2 = Client.create(identifier: "Anthony", root_url: "turing")
      rt = RequestType.create(http_verb: "GET")
      rt2 = RequestType.create(http_verb: "POST")
      Payload.create(requested_at: "test",
                     responded_in: 5,
                     referred_by_id: 2,
                     request_type_id: rt.id,
                     event_id: 2,
                     agent_id: 5,
                     resolution_id: 4,
                     ip_id: 2,
                     url_id: 1,
                     client_id: c.id)

      Payload.create(requested_at: "test",
                      responded_in: 10,
                      referred_by_id: 2,
                      request_type_id: rt.id,
                      event_id: 2,
                      agent_id: 5,
                      resolution_id: 4,
                      ip_id: 2,
                      url_id: 1,
                      client_id: c.id)

        Payload.create(requested_at: "test",
                        responded_in: 10,
                        referred_by_id: 2,
                        request_type_id: rt2.id,
                        event_id: 2,
                        agent_id: 5,
                        resolution_id: 4,
                        ip_id: 2,
                        url_id: 1,
                        client_id: c.id)

        Payload.create(requested_at: "test",
                       responded_in: 15,
                       referred_by_id: rt2.id,
                       request_type_id: 3,
                       event_id: 2,
                       agent_id: 5,
                       resolution_id: 4,
                       ip_id: 2,
                       url_id: 1,
                       client_id: c2.id)

        expect(c.most_frequent_request_type).to eq("GET")
      end

      it "can return all request types" do
        c = Client.create(identifier: "Bradanthony", root_url: "turing")
        c2 = Client.create(identifier: "Anthony", root_url: "turing")
        rt = RequestType.create(http_verb: "GET")
        rt2 = RequestType.create(http_verb: "POST")
        Payload.create(requested_at: "test",
                       responded_in: 5,
                       referred_by_id: 2,
                       request_type_id: rt.id,
                       event_id: 2,
                       agent_id: 5,
                       resolution_id: 4,
                       ip_id: 2,
                       url_id: 1,
                       client_id: c.id)

        Payload.create(requested_at: "test",
                        responded_in: 10,
                        referred_by_id: 2,
                        request_type_id: rt.id,
                        event_id: 2,
                        agent_id: 5,
                        resolution_id: 4,
                        ip_id: 2,
                        url_id: 1,
                        client_id: c.id)

          Payload.create(requested_at: "test",
                          responded_in: 10,
                          referred_by_id: 2,
                          request_type_id: rt2.id,
                          event_id: 2,
                          agent_id: 5,
                          resolution_id: 4,
                          ip_id: 2,
                          url_id: 1,
                          client_id: c.id)

          Payload.create(requested_at: "test",
                         responded_in: 15,
                         referred_by_id: rt2.id,
                         request_type_id: 3,
                         event_id: 2,
                         agent_id: 5,
                         resolution_id: 4,
                         ip_id: 2,
                         url_id: 1,
                         client_id: c2.id)

      expect(c.all_request_types).to eq(["GET", "POST"])
    end

    it "can return urls in descending order" do
      c = Client.create(identifier: "Bradanthony", root_url: "turing")
      c2 = Client.create(identifier: "Anthony", root_url: "turing")
      url = Url.create(root_url: "google.com", path: "/images")
      url2 = Url.create(root_url: "yahoo.com", path: "/images")


      Payload.create(requested_at: "test",
                     responded_in: 5,
                     referred_by_id: 2,
                     request_type_id: 1,
                     event_id: 2,
                     agent_id: 5,
                     resolution_id: 4,
                     ip_id: 2,
                     url_id: url.id,
                     client_id: c.id)

      Payload.create(requested_at: "test",
                      responded_in: 10,
                      referred_by_id: 2,
                      request_type_id: 2,
                      event_id: 2,
                      agent_id: 5,
                      resolution_id: 4,
                      ip_id: 2,
                      url_id: url.id,
                      client_id: c.id)

        Payload.create(requested_at: "test",
                        responded_in: 10,
                        referred_by_id: 2,
                        request_type_id: 3,
                        event_id: 2,
                        agent_id: 5,
                        resolution_id: 4,
                        ip_id: 2,
                        url_id: url2.id,
                        client_id: c.id)

        Payload.create(requested_at: "test",
                       responded_in: 15,
                       referred_by_id: 2,
                       request_type_id: 3,
                       event_id: 2,
                       agent_id: 5,
                       resolution_id: 4,
                       ip_id: 2,
                       url_id: url.id,
                       client_id: c2.id)

    expect(c.urls_descending).to eq(["google.com/images", "yahoo.com/images"])
  end

  it "payload browser breakdown for particular client" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    c2 = Client.create(identifier: "Anthony", root_url: "turing")
    chrome = Agent.create(browser: "chrome", operating_system: "mac os")
    safari = Agent.create(browser: "safari", operating_system: "mac os")
    mozilla = Agent.create(browser: "mozilla", operating_system: "mac os")

    Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: 8,
                 request_type_id: 1,
                 event_id: 7,
                 agent_id: chrome.id,
                 resolution_id: 1,
                 url_id: 1,
                 ip_id: 1,
                 client_id: c.id)

   Payload.create(requested_at: "test",
                responded_in: 12,
                referred_by_id: 8,
                request_type_id: 1,
                event_id: 7,
                agent_id: mozilla.id,
                resolution_id: 1,
                url_id: 1,
                ip_id: 1,
                client_id: c.id)

    Payload.create(requested_at: "test",
                responded_in: 12,
                referred_by_id: 8,
                request_type_id: 1,
                event_id: 7,
                agent_id: safari.id,
                resolution_id: 1,
                url_id: 1,
                ip_id: 1,
                client_id: c.id)
    Payload.create(requested_at: "test",
                responded_in: 12,
                referred_by_id: 8,
                request_type_id: 1,
                event_id: 7,
                agent_id: safari.id,
                resolution_id: 1,
                url_id: 1,
                ip_id: 1,
                client_id: c2.id)

    expect(c.browser_breakdown).to eq({"safari"=>1, "chrome"=>1, "mozilla"=>1})
  end

  it "returns operating system breakdown accross payloads on particular client" do
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    c2 = Client.create(identifier: "Anthony", root_url: "turing")
    chrome = Agent.create(browser: "chrome", operating_system: "mac os")
    safari = Agent.create(browser: "safari", operating_system: "windows os")

    Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: 8,
                 request_type_id: 1,
                 event_id: 7,
                 agent_id: chrome.id,
                 resolution_id: 1,
                 url_id: 1,
                 ip_id: 1,
                 client_id: c.id)

   Payload.create(requested_at: "test",
                responded_in: 12,
                referred_by_id: 8,
                request_type_id: 1,
                event_id: 7,
                agent_id: safari.id,
                resolution_id: 1,
                url_id: 1,
                ip_id: 1,
                client_id: c.id)

    Payload.create(requested_at: "test",
                responded_in: 12,
                referred_by_id: 8,
                request_type_id: 1,
                event_id: 7,
                agent_id: safari.id,
                resolution_id: 1,
                url_id: 1,
                ip_id: 1,
                client_id: c2.id)

    expect(c.os_breakdown).to eq({"windows os"=>1, "mac os"=>1})
  end

  it "returns resoltions accross all payloads for particular client" do
    one = Resolution.create(height: "11", width: "9")
    two = Resolution.create(height: "10", width: "8")
    c = Client.create(identifier: "Bradanthony", root_url: "turing")
    c2 = Client.create(identifier: "Anthony", root_url: "turing")

    Payload.create(requested_at: "test",
                 responded_in: 12,
                 referred_by_id: 8,
                 request_type_id: 1,
                 event_id: 7,
                 agent_id: 1,
                 resolution_id: two.id,
                 url_id: 1,
                 ip_id: 1,
                 client_id: c.id)

   Payload.create(requested_at: "test",
                responded_in: 12,
                referred_by_id: 8,
                request_type_id: 1,
                event_id: 7,
                agent_id: 1,
                resolution_id: one.id,
                url_id: 1,
                ip_id: 1,
                client_id: c.id)

    Payload.create(requested_at: "test",
                responded_in: 12,
                referred_by_id: 8,
                request_type_id: 1,
                event_id: 7,
                agent_id: 1,
                resolution_id: two.id,
                url_id: 1,
                ip_id: 1,
                client_id: c2.id)

    expect(c.resolutions_breakdown).to eq({{"height"=>"10", "width"=>"8"}=>1, {"height"=>"11", "width"=>"9"}=>1})
  end
end
