class CreateInvites < ActiveRecord::Migration[8.0]
  def change
    create_table :invites do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :token, null: false
      t.boolean :active, default: true, null: false
      t.datetime :expires_at
      t.references :created_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :invites, :token, unique: true
  end
end
