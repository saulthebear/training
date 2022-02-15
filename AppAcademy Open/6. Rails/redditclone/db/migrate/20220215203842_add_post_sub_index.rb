class AddPostSubIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :post_subs, %i[post_id sub_id]
  end
end
