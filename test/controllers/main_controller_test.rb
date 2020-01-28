require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get main_landing_url
    assert_response :success
  end

  test "should get about" do
    get main_about_url
    assert_response :success
  end

  test "should get help" do
    get main_help_url
    assert_response :success
  end

end
