class AddGenreToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :genre, :string
  end
end
