class DropCommentsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :comments
  end

  def down
    create_table :comments do |t|
      t.text :content
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
