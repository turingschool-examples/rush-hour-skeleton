require './test/test_helper'

class UserTest < Minitest::Test

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_is_valid_with_an_identifier_and_root_url
  	user = User.new({ 'identifier' => 'jumpstartlab',
  		                'rootUrl'    => 'http://jumpstartlab.com'})
  	assert user.valid?
  end

  def test_it_is_invalid_without_an_identifier
  	user = User.new({'rootUrl'    => 'http://jumpstartlab.com'})
  	refute user.valid?
  end

  def test_it_is_invalid_without_a_rooturl
  	user = User.new({'identifier' => 'jumpstartlab'})
  	refute user.valid?
  end

  def test_cannot_create_duplicate_user
  	#why use create/new instead of create/create
    #accomplishes same result, why not further test db?
    user1 = User.create({ 'identifier' => 'jumpstartlab',
  		                    'rootUrl'    => 'http://jumpstartlab.com'})
  	user2 = User.new({ 'identifier' => 'jumpstartlab',
  		                 'rootUrl'    => 'http://jumpstartlab.com'})
  	refute user2.valid?
  	assert_equal 1, User.count
  end
 end