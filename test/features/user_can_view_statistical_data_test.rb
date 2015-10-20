class UserGetsURLStatisticsTest <FeatureTest
  def test_registered_user_will_recieve_statistical_data
    create_user(1)
    create_url(1)

    visit ('/sources/IDENTIFIER/urls/RELATIVE/PATH')

    assert_equal '/sources/IDENTIFIER/urls/RELATIVE/PATH', current_path

    assert page.has_content?("Longest response time")
    assert page.has_content?("Shortest response time")
    assert page.has_content?("Average response time")
    assert page.has_content?("HTTP verbs")
    assert page.has_content?("Referrrers")
    assert page.has_content?("User agents")
  end

  def test_if_identifier_relative_or_path_is_missing_it_redirects_to_error_page
    create_user(1)

    visit ('/sources/IDENTIFIER/urls/RELATIVE/PATH')

    assert_equal '/sources/IDENTIFIER/urls/RELATIVE/PATH', current_path

    refute page.has_content?("Longest response time")
    refute page.has_content?("Shortest response time")
    refute page.has_content?("Average response time")
    refute page.has_content?("HTTP verbs")
    refute page.has_content?("Referrrers")
    refute page.has_content?("User agents")
  end

end
