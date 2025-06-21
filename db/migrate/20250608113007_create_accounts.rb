class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :provider
      t.string :uid
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end

    add_index :accounts, :email, unique: true
    add_index :accounts, :reset_password_token, unique: true
    add_index :accounts, [ :provider, :uid ], unique: true
  end
end
