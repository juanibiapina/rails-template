class AddUserToTrips < ActiveRecord::Migration[8.0]
  def change
    add_reference :trips, :user, null: false, foreign_key: true
  end
end
