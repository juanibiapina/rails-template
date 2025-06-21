require "test_helper"

class Accounts::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "controller inherits from Devise::OmniauthCallbacksController" do
    assert Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  end
end
