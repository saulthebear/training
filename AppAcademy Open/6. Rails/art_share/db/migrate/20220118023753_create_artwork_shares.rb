class CreateArtworkShares < ActiveRecord::Migration[6.1]
  def change
    create_table :artwork_shares do |t|
      t.integer :artwork_id, null: false, index: true
      t.integer :viewer_id, null: false, index: true

      t.timestamps
    end
    add_index(:artwork_shares, [:viewer_id, :artwork_id], unique: true)
  end
end
