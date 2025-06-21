class EnsureAllTripsHaveOwnerMemberships < ActiveRecord::Migration[8.0]
  def up
    # For each trip that doesn't have an owner membership, create one based on the legacy user_id
    Trip.find_each do |trip|
      unless TripMembership.exists?(trip: trip, role: "owner")
        TripMembership.create!(trip: trip, user_id: trip.user_id, role: "owner")
      end
    end
  end

  def down
    # Remove owner memberships that were created by this migration
    # This is safe because we only remove memberships where the user_id matches the trip's user_id
    Trip.find_each do |trip|
      membership = TripMembership.find_by(trip: trip, user_id: trip.user_id, role: "owner")
      membership&.destroy
    end
  end
end
