class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content
      t.integer :sub_id, null: false
      t.integer :author_id, null: false

      t.timestamps
    end

    add_foreign_key :posts, :subs
    add_foreign_key :posts, :users, column: :author_id
  end
end
