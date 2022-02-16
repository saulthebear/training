class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.bigint :author_id, null: false
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key :comments, :users, column: :author_id
  end
end
