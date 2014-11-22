class AddRatingToBook < ActiveRecord::Migration
  def change
    add_column :books, :rating, :integer, default: 0
  end
end
