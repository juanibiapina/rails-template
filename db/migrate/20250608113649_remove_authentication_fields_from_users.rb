class RemoveAuthenticationFieldsFromUsers < ActiveRecord::Migration[8.0]
  def up
    remove_index :users, :email
    remove_index :users, :reset_password_token
    remove_index :users, [ :provider, :uid ]

    remove_column :users, :email
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
    remove_column :users, :provider
    remove_column :users, :uid
  end

  def down
    add_column :users, :email, :string, null: false, default: ""
    add_column :users, :encrypted_password, :string, null: false, default: ""
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at, :datetime
    add_column :users, :provider, :string
    add_column :users, :uid, :string

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, [ :provider, :uid ], unique: true

    # Copy data back from accounts to users
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
  end
end
