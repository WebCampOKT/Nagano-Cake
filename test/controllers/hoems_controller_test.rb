require "test_helper"

class HoemsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get hoems_top_url
    assert_response :success
  end

  test "should get about" do
    get hoems_about_url
    assert_response :success
  end
end
