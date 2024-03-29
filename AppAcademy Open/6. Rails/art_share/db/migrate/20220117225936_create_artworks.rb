class CreateArtworks < ActiveRecord::Migration[6.1]
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.integer :artist_id, index: true

      t.timestamps
    end
    
    add_index(:artworks, [:title, :artist_id], unique: true)
  end
end
