require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:one)
    sign_in @account
  end

  test "should get index when authenticated" do
    get root_url
    assert_response :success
    assert_select "h1", text: "Welcome to Your Rails App"
  end

  test "should redirect to login when not authenticated" do
    sign_out @account
    get root_url
    assert_redirected_to new_account_session_path
  end
end
