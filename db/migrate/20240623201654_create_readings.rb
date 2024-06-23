class CreateReadings < ActiveRecord::Migration[7.1]
  def change
    create_table :readings do |t|
      t.string :status
      t.date :start_date
      t.date :end_date
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
