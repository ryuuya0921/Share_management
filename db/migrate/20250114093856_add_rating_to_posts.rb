class AddRatingToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :rating, :integer
  end
end
