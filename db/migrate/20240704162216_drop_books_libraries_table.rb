class DropBooksLibrariesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :books_libraries
  end

  def down
    create_table :books_libraries, id: false do |t|
      t.integer :library_id, null: false
      t.integer :book_id, null: false
      t.index :book_id
      t.index :library_id
    end
  end
end
