require "test_helper"

class AccountTest < ActiveSupport::TestCase
  def google_auth_hash(email: "test@example.com", uid: "123456789", name: "Test User", image: "https://example.com/picture.jpg")
    OmniAuth::AuthHash.new({
      provider: "google",
      uid: uid,
      info: {
        email: email,
        name: name,
        image: image
      }
    })
  end

  test "should include omniauthable in devise modules" do
    assert Account.devise_modules.include?(:omniauthable)
  end

  test "should have google as omniauth provider" do
    assert_includes Account.omniauth_providers, :google
  end

  test "should create account and user from omniauth" do
    auth = google_auth_hash

    assert_difference [ "Account.count", "User.count" ], 1 do
      account = Account.from_omniauth(auth)
      assert account.persisted?
      assert_equal "test@example.com", account.email
      assert_equal "google", account.provider
      assert_equal "123456789", account.uid
      assert_equal "Test User", account.user.name
      assert_equal "https://example.com/picture.jpg", account.user.picture
      assert account.valid_password?(account.password) # Should have a generated password
    end
  end

  test "should find existing account by user email from omniauth" do
    existing_user = User.create!(name: "Existing User")
    existing_account = Account.create!(
      user: existing_user,
      email: "existing@example.com",
      password: "password123"
    )

    auth = google_auth_hash(email: "existing@example.com", name: "Updated User", image: "https://example.com/existing.jpg")

    assert_no_difference [ "Account.count", "User.count" ] do
      account = Account.from_omniauth(auth)
      assert_equal existing_account.id, account.id
      assert_equal "existing@example.com", account.email
      # Should update provider and uid for existing account
      assert_equal "google", account.provider
      assert_equal "123456789", account.uid
      # Should update name and picture for existing user
      assert_equal "Updated User", account.user.name
      assert_equal "https://example.com/existing.jpg", account.user.picture
    end
  end

  test "should handle multiple oauth providers for same email" do
    # Create account with Google OAuth first
    auth1 = google_auth_hash(email: "multi@example.com", uid: "111", name: "Multi User", image: "https://example.com/multi1.jpg")
    account1 = Account.from_omniauth(auth1)

    # Try to create/find account with same email but different uid
    auth2 = google_auth_hash(email: "multi@example.com", uid: "222", name: "Multi User Updated", image: "https://example.com/multi2.jpg")

    assert_no_difference [ "Account.count", "User.count" ] do
      account2 = Account.from_omniauth(auth2)
      assert_equal account1.id, account2.id
      assert_equal "multi@example.com", account2.email
      # Should update to the latest OAuth data
      assert_equal "Multi User Updated", account2.user.name
      assert_equal "https://example.com/multi2.jpg", account2.user.picture
    end
  end

  test "should handle oauth data with missing name or picture" do
    # Test with missing name - OmniAuth falls back to email for name
    auth_no_name = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "no_name",
      info: {
        email: "no_name@example.com",
        image: "https://example.com/picture.jpg"
      }
    })

    account = Account.from_omniauth(auth_no_name)
    assert account.persisted?
    assert_equal "no_name@example.com", account.user.name  # OmniAuth falls back to email
    assert_equal "https://example.com/picture.jpg", account.user.picture

    # Test with missing picture
    auth_no_picture = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "no_picture",
      info: {
        email: "no_picture@example.com",
        name: "User With No Picture"
      }
    })

    account2 = Account.from_omniauth(auth_no_picture)
    assert account2.persisted?
    assert_equal "User With No Picture", account2.user.name
    assert_nil account2.user.picture
  end
end
