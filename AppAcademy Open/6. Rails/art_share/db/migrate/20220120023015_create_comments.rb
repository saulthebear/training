class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :commenter_id, null: false, index: true
      t.string :artwork_id, null: false, index: true
      t.string :body, null: false

      t.timestamps
    end
  end
end
