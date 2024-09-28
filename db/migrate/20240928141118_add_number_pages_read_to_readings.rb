class AddNumberPagesReadToReadings < ActiveRecord::Migration[7.1]
  def change
    add_column :readings, :number_pages_read, :integer
  end
end
