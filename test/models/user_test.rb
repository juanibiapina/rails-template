require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should have account association" do
    user = User.create!(name: "Test User")
    assert_respond_to user, :account
  end

  test "should require name" do
    user = User.new
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "should create user with valid name" do
    user = User.new(name: "Test User")
    assert user.valid?
  end
end
