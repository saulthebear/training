require_relative 'questions'
require_relative 'question'
require_relative 'user'

class QuestionLike
  attr_accessor :question_id, :user_id

  def self.find_by_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT * FROM question_likes WHERE question_id = ?
    SQL
    QuestionLike.new(data.first)
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id
      FROM
        question_likes AS likes
          JOIN users ON likes.user_id = users.id
      WHERE
        likes.question_id = ?
    SQL

    return [] if data.length.zero?

    data.map { |datum| User.find_by_id(datum['id']) }
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS num_likes
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    data.first['num_likes']
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        question_id AS id,
        author_id,
        title,
        body
      FROM
        question_likes AS likes
        JOIN
          questions ON likes.question_id = questions.id
      WHERE
        user_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(limit)
    data = QuestionsDatabase.instance.execute(<<-SQL, limit)
      SELECT
        question_id,
          COUNT(*)
      FROM
        question_likes
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
