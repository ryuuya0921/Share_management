class CreatePlazaPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :plaza_posts do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
