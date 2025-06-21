class DropTripSpecificTables < ActiveRecord::Migration[8.0]
  def up
    # Drop tables in the correct order to avoid foreign key constraint issues
    drop_table :transport_users, if_exists: true
    drop_table :transports, if_exists: true
    drop_table :trip_events, if_exists: true
    drop_table :trip_memberships, if_exists: true
    drop_table :invites, if_exists: true
    drop_table :places, if_exists: true
    drop_table :trips, if_exists: true
  end

  def down
    # This is irreversible - we're intentionally removing trip functionality
    raise ActiveRecord::IrreversibleMigration
  end
end
