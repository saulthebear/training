class CreateAnswerChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :answer_choices do |t|
      t.integer :question_id
      t.string :text

      t.timestamps
    end
  end
end
