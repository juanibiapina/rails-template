class CreateTransportUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :transport_users do |t|
      t.references :transport, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :transport_users, [ :transport_id, :user_id ], unique: true
  end
end
