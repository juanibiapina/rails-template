class DropLinksTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :links do |t|
      t.string :url
      t.references :trip, null: false, foreign_key: true
      t.timestamps
    end
  end
end
