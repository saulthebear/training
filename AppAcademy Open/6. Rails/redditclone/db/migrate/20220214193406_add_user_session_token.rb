class AddUserSessionToken < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :session_token, null: false, index: { unique: true }
    end
  end
end
