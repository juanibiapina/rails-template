require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @account = accounts(:one)
    sign_in @account
  end

  test "visiting the home page" do
    visit root_url
    assert_selector "h1", text: "Welcome to Your Rails App"
    assert_text "Hello, #{@user.name}!"
  end

  test "should have sign out link" do
    visit root_url
    assert_link "Sign Out"
  end
end
