class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :description
      t.string :image_url
      t.string :book_type
      t.text :review
      t.timestamps
    end

    add_index :books, :title, unique: true

  end
end
