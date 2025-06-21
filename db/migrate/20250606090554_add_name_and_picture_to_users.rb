class AddNameAndPictureToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :picture, :string
  end
end
