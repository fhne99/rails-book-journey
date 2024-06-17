class AddFieldsToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :published_year, :integer
    add_column :books, :number_of_pages, :integer
  end
end
