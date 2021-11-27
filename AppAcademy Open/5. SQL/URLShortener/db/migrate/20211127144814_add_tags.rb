class AddTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_topics do |t|
      t.string :name, null: false

      t.index :name

      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :url_id, null: false
      t.integer :topic_id, null: false

      t.index :url_id
      t.index :topic_id

      t.timestamps
    end
  end
end
