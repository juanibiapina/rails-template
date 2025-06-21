class MigrateAuthenticationDataToAccounts < ActiveRecord::Migration[8.0]
  def up
    # Create account records for all existing users
    User.find_each do |user|
      # For users without passwords (OAuth users), generate a random password
      password = user.encrypted_password.present? ? user.encrypted_password : Devise::Encryptor.digest(Account, Devise.friendly_token[0, 20])

      # Skip validations during migration to avoid password presence validation
      account = Account.new(
        user: user,
        email: user.email,
        encrypted_password: password,
        provider: user.provider,
        uid: user.uid,
        reset_password_token: user.reset_password_token,
        reset_password_sent_at: user.reset_password_sent_at,
        remember_created_at: user.remember_created_at,
        created_at: user.created_at,
        updated_at: user.updated_at
      )
      account.save!(validate: false)
    end
  end

  def down
    # Copy authentication data back to users and delete accounts
    Account.find_each do |account|
      user = account.user
      user.update!(
        email: account.email,
        encrypted_password: account.encrypted_password,
        provider: account.provider,
        uid: account.uid,
        reset_password_token: account.reset_password_token,
        reset_password_sent_at: account.reset_password_sent_at,
        remember_created_at: account.remember_created_at
      )
    end

    Account.delete_all
  end
end
