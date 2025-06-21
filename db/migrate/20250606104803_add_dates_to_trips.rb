class AddDatesToTrips < ActiveRecord::Migration[8.0]
  def change
    add_column :trips, :start_date, :date, null: false
    add_column :trips, :end_date, :date, null: false
  end
end
