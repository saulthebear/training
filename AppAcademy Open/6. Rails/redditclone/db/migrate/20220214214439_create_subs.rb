class CreateSubs < ActiveRecord::Migration[6.1]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.string :description
      t.integer :moderator_id, null: false

      t.timestamps
    end

    add_foreign_key :subs, :users, column: :moderator_id
  end
end
