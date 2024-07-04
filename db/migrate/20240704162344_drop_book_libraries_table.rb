class DropBookLibrariesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :book_libraries
  end

  def down
    create_table :book_libraries do |t|
      t.integer :book_id, null: false
      t.integer :library_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index :book_id
      t.index :library_id
    end
  end
end
