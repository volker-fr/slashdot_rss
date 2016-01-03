require 'test_helper'

class RssControllerTest < ActionController::TestCase
  test "should get all" do
    get :all
    assert_response :success
  end

  test "should get top3" do
    get :top3
    assert_response :success
  end

  test "should get topweek" do
    get :topweek
    assert_response :success
  end

  test "should get topall" do
    get :topall
    assert_response :success
  end

end
