class AddChildComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :parent_comment_id, :bigint
    add_foreign_key :comments, :comments, column: :parent_comment_id
  end
end
