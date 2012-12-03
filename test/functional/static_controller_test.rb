require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test "should get confirmation" do
    get :confirmation
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
