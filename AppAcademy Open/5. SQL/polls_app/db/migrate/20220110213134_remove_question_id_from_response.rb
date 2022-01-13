class RemoveQuestionIdFromResponse < ActiveRecord::Migration[6.1]
  def change
    remove_column :responses, :question_id, :integer
  end
end
