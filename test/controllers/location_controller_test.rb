require 'test_helper'

class LocationControllerTest < ActionController::TestCase
  test "should get init_enum" do
    get :init_enum
    assert_response :success
  end

  test "should get get_next_loc" do
    get :get_next_loc
    assert_response :success
  end

  test "should get has_more_locs" do
    get :has_more_locs
    assert_response :success
  end

  test "should get all_locations" do
    get :all_locations
    assert_response :success
  end

  test "should get get_weather" do
    get :get_weather
    assert_response :success
  end

  test "should get get_prediction" do
    get :get_prediction
    assert_response :success
  end

  test "should get find_nearest_location" do
    get :find_nearest_location
    assert_response :success
  end

end
