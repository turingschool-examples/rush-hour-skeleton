require "./test/test_helper"

class MainPageTest < Minitest::Test



  include Capybara::DSL

    def test_user_sees_greeting
      visit '/'
      within ('h1') do
        assert page.has_content?("Hello")
      end
    end

    

end
