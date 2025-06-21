require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  test "user can create account with name, sign out, and sign in again" do
    # Generate unique email for this test
    email = "test_user_#{Time.current.to_i}@example.com"
    password = "testpassword123"
    name = "John Doe"

    # Step 1: Create an account (sign up)
    visit new_account_registration_path

    # Ensure the page loaded properly and has required fields
    assert_current_path new_account_registration_path
    assert_selector "h2", text: "Sign up"
    assert_selector "label", text: "Name"
    assert_selector "input[name='account[name]']"

    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_on "Sign up"

    # Should be redirected to home page after successful signup
    assert page.has_selector?("h1", text: "Welcome to Your Rails App"), "Should be on home page with welcome heading"

    # Step 2: Sign out
    # Open the user dropdown menu first
    find("button[aria-label='User menu']").click
    click_on "Sign out"

    # After sign out, user should be redirected and no longer see the user menu
    # Wait for the page to load after sign out
    sleep(0.5)
    assert_not page.has_selector?("button[aria-label='User menu']"), "User menu should not be visible after signing out"

    # Step 3: Sign in again with the same credentials
    visit new_account_session_path  # Go to sign in page
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on "Log in"

    # Should be redirected back to home page after successful sign in
    assert page.has_selector?("h1", text: "Welcome to Your Rails App"), "Should be back on home page after sign in"
    assert page.has_selector?("button[aria-label='User menu']"), "User menu should be visible after signing in"
  end
end
