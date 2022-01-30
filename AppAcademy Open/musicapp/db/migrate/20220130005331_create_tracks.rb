class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.integer :ord, null: false
      t.text :lyrics
      t.boolean :is_bonus, default: false, null: false

      t.timestamps
    end
    
    add_reference :tracks, :album
  end
end
