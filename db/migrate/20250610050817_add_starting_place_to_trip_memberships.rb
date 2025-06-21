class AddStartingPlaceToTripMemberships < ActiveRecord::Migration[8.0]
  def change
    add_reference :trip_memberships, :starting_place, null: true, foreign_key: { to_table: :places }
  end
end
