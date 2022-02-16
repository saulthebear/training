class RemovePostSubId < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :posts, :subs
    remove_column :posts, :sub_id
  end
end
