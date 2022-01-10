class AddIndices < ActiveRecord::Migration[6.1]
  def change
    add_index :answer_choices, :question_id
    add_index :polls, :author_id
    add_index :responses, :user_id
    add_index :responses, :question_id
    add_index :responses, :answer_choice_id
    add_index :users, :username, unique: true
  end
end
