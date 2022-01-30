class CreateAlbum < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :is_live, default: false

      t.timestamps
    end

    add_reference :albums, :band
  end
end
