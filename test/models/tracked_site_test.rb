require './test/test_helper'

module TrafficSpy
  class ClientTest < Minitest::Test 

    def setup
      DatabaseCleaner.start
      TestData.clients.each do |client|
        ClientValidator.validate(client)
      end
      TestData.feature_tests.each do |payload|
        PayloadValidator.validate(payload[0]["payload"], payload[1])
      end
    end

    


    def teardown
      DatabaseCleaner.clean
    end
  end
end



