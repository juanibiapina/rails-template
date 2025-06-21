require "application_system_test_case"

class TurboTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @account = accounts(:one)
    sign_in @account
  end

  test "turbo javascript is loaded" do
    visit root_url

    # Check that Turbo JavaScript modules are available
    turbo_loaded = page.evaluate_script("typeof Turbo !== 'undefined'")
    assert turbo_loaded, "Turbo should be loaded and available"
  end

  test "stimulus javascript is loaded" do
    visit root_url

    # Check that Stimulus is available
    stimulus_loaded = page.evaluate_script("typeof Stimulus !== 'undefined'")
    assert stimulus_loaded, "Stimulus should be loaded and available"
  end
end
