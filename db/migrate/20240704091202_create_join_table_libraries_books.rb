class CreateJoinTableLibrariesBooks < ActiveRecord::Migration[7.1]
  def change
    create_join_table :libraries, :books do |t|
      t.index :library_id
      t.index :book_id
    end
  end
end
