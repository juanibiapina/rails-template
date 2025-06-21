class CreateTransports < ActiveRecord::Migration[8.0]
  def change
    create_table :transports do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :trip, null: false, foreign_key: true
      t.references :origin_place, null: false, foreign_key: { to_table: :places }
      t.references :destination_place, null: false, foreign_key: { to_table: :places }

      t.timestamps
    end
  end
end
