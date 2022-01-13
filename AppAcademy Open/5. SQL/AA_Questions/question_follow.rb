require_relative 'questions'
require_relative 'question'
require_relative 'user'

class QuestionFollow
  attr_accessor :question_id, :user_id

  def self.find_by_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT * FROM question_follows WHERE question_id = ?
    SQL
    QuestionFollow.new(data.first)
  end

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        user_id AS id,
        fname,
        lname
      FROM
        question_follows AS follows
        JOIN
          users ON follows.user_id = users.id
      WHERE
        question_id = ?
    SQL
    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        question_id AS id,
        author_id,
        title,
        body
      FROM
        question_follows AS follows
        JOIN
          questions ON follows.question_id = questions.id
      WHERE
        user_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(limit)
    data = QuestionsDatabase.instance.execute(<<-SQL, limit)
      SELECT
        question_id,
          COUNT(*)
      FROM
        question_follows
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
    data.map { |datum| Question.find_by_id(datum['question_id']) }
  end
  
  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
