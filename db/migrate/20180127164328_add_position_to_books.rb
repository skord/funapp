class AddPositionToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :position, :integer
  end
end
