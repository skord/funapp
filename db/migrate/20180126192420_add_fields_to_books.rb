class AddFieldsToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :author, :string
    add_column :books, :cover, :string
    add_column :books, :description, :text
    add_column :books, :genre, :string
    add_column :books, :isbn, :string
  end
end
