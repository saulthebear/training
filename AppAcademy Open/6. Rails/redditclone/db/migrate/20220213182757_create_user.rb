class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
