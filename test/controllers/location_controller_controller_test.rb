require 'test_helper'

class LocationControllerControllerTest < ActionController::TestCase
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

  test "should get retrieve_all_locations" do
    get :retrieve_all_locations
    assert_response :success
  end

  test "should get get_weather_location" do
    get :get_weather_location
    assert_response :success
  end

  test "should get get_weather_coordinate" do
    get :get_weather_coordinate
    assert_response :success
  end

  test "should get get_prediction_location" do
    get :get_prediction_location
    assert_response :success
  end

  test "should get get_prediction_coordinate" do
    get :get_prediction_coordinate
    assert_response :success
  end

end
