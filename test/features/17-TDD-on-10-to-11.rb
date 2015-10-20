class UserGetsURLStatisticsTest <FeatureTest
  def test_registered_user_will_recieve_statistical_data
    register_application
    post_request

    visit ('http://yourapplication:port/sources/IDENTIFIER/urls/RELATIVE/PATH')

    assert_equal '/sources/IDENTIFIER/urls/RELATIVE/PATH', current_path

    within("#URL") do
      assert page.has_content?("expected data")
    end
  end

  def test_if_identifier_relative_or_path_is_missing_it_redirects_to_error_page
    visit('http://yourapplication:port/sources/IDENTIFIER/urls/RELATIVE/PATH')

    assert_equal 'yourapplication:port/error', current_path

end
