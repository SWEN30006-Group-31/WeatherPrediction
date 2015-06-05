require 'test_helper'

class PostcodeControllerTest < ActionController::TestCase
  test "should get get_weather" do
    get :get_weather
    assert_response :success
  end

  test "should get get_prediction" do
    get :get_prediction
    assert_response :success
  end

end
