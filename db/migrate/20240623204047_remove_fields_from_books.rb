class RemoveFieldsFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :start_date, :date
    remove_column :books, :end_date, :date
    remove_column :books, :status, :string
    remove_column :books, :rating, :integer
    remove_column :books, :comment, :text
  end
end
