require_relative 'import_questions_classes'

class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM users WHERE id = ?
    SQL
    User.new(data.first)
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT * FROM users
      WHERE
        fname = ?
        AND
        lname = ?
    SQL
    User.new(data.first)
  end
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def save
    return update if @id

    QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      INSERT
        INTO users (fname, lname)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id

    self
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    data = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        (
            CAST(COUNT(question_id) AS float)
            / 
            COUNT(DISTINCT(id))
          ) AS average_karma
      FROM
        questions
          LEFT OUTER JOIN
            question_likes likes
            ON questions.id = likes.question_id
      WHERE
        questions.author_id = ?
    SQL
    data.first['average_karma']
  end

  private

  def update
    raise 'This record does not exist' unless @id

    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE users
      SET
        fname = ?,
        lname = ?
      WHERE
        id = ?
    SQL

    self
  end
end
