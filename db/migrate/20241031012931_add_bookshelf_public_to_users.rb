class AddBookshelfPublicToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bookshelf_public, :boolean
  end
end
