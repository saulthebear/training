class SetNotNullConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:users, :username, false)

    change_column_null(:polls, :author_id, false)
    change_column_null(:polls, :title, false)

    change_column_null(:responses, :user_id, false)
    change_column_null(:responses, :question_id, false)
    change_column_null(:responses, :answer_choice_id, false)

    change_column_null(:questions, :poll_id, false)
    change_column_null(:questions, :text, false)
    
    change_column_null(:answer_choices, :question_id, false)
  end
end
