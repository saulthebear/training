class AddSessionTokenConstraint < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, :session_token
    add_index :users, :session_token, unique: true
  end
end
