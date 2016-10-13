require_relative '../spec_helper'

RSpec.describe "Url" do
  describe "validation" do
    it "is invalid without url_address" do
      url = Url.create

      expect(url).to_not be_valid
    end

    it "is valid with url_address" do
      url = Url.create( url_address: "www.google.com")

      expect(url).to be_valid
    end

    it "has a unique url address" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.google.com")

      expect(url2).to_not be_valid
    end
  end

  describe ".most_to_least_requested" do
    it "lists urls from most requested to least" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      build_payloads_linked_with_urls(url1, url2)

      most_to_least = [url1.url_address, url2.url_address]
      expect(Url.most_to_least_requested).to eq(most_to_least)
    end
  end

  describe ".max_response_time" do
    it "returns max response time for a specific url" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      build_payloads_linked_with_urls(url1, url2)

      expect(url1.max_response_time).to eq(38)
    end
  end

  describe "min_response_time" do
    it "returns min response time for a specific url" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      build_payloads_linked_with_urls(url1, url2)

      expect(url1.min_response_time).to eq(37)
    end

    it "returns max response time for a specific url" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      build_payloads_linked_with_urls(url1, url2)

      expect(url1.average_response_time).to eq(37.5)
    end
  end

  describe "longest_to_shortest_response_time" do
    it "returns an array of longest to shortest response times" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.yahoo.com")

      build_payloads_linked_with_urls(url1, url2)

      response_times = [38, 37]
      expect(url1.longest_to_shortest_response_time).to eq(response_times)
    end
  end

  describe ".list_of_http_verbs" do
    it "return the list of all http verbs across payloads" do
      url = Url.create(url_address: "http://jumpstartlab.com")

      build_linked_requests_and_payloads_for_url(url)

      all_verbs = ["GET", "POST" , "PUT"]
      expect(url.list_of_http_verbs).to eq(all_verbs)
    end
  end


  describe ".three_most_popular_referrals" do
    it "returns three most popular referrers" do
      url = Url.create(url_address: "http://jumpstartlab.com")

      build_linked_referrals_and_payloads_for_url(url)

      top_three = ["http://coursereport.com", "http://google.com", "http://turing.io"]
      expect(url.three_most_popular_referrals).to eq(top_three)
    end
  end

  describe ".three_most_popular_user_agents" do
    it "returns three most popular user agents" do
      url = Url.create(url_address: "http://jumpstartlab.com")

      build_linked_user_agent_stats_and_payloads_for_url(url)

      top_three = [["Chrome", "Mac OS"], ["Chrome", "Windows"], ["Safari", "Mac OS"]]
      expect(url.three_most_popular_user_agents).to eq(top_three)
    end
  end

  describe ".get_relative_path" do
    it "formats the full url" do
      url = Url.create(url_address: "http://google.com/about")

      expect(url.get_relative_path).to eq("about")
    end
  end
end
