class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.date :start_date
      t.date :end_date
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
