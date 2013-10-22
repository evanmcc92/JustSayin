require 'test_helper'

class BrowseControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get votedup" do
    get :votedup
    assert_response :success
  end

  test "should get voteddown" do
    get :voteddown
    assert_response :success
  end

  test "should get refreshposts" do
    get :refreshposts
    assert_response :success
  end

  test "should get update_poststream" do
    get :update_poststream
    assert_response :success
  end

  test "should get aboutus" do
    get :aboutus
    assert_response :success
  end

  test "should get message" do
    get :message
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

end
