class CreateTripEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :trip_events do |t|
      t.string :title, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
