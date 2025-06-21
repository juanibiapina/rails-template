class RemoveUserFromTrips < ActiveRecord::Migration[8.0]
  def up
    remove_foreign_key :trips, :users
    remove_column :trips, :user_id
  end

  def down
    add_reference :trips, :user, null: false, foreign_key: true
  end
end
