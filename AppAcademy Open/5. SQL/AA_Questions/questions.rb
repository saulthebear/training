require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

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

class Question
  attr_accessor :id, :author_id, :title, :body

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM questions WHERE id = ?
    SQL
    Question.new(data.first)
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT * FROM questions WHERE author_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed(limit)
    QuestionFollow.most_followed_questions(limit)
  end

  def self.most_liked(limit)
    QuestionLike.most_liked_questions(limit)
  end

  def initialize(options)
    @id = options['id']
    @author_id = options['author_id']
    @title = options['title']
    @body = options['body']
  end

  def save
    return update if @id

    QuestionsDatabase.instance.execute(<<-SQL, @author_id, @title, @body)
      INSERT
        INTO questions (author_id, title, body)
      VALUES
        (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id

    self
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  private

  def update
    raise 'This record does not exist' unless @id

    QuestionsDatabase.instance.execute(<<-SQL, @author_id, @title, @body, @id)
      UPDATE questions
      SET
        author_id = ?,
        title = ?,
        body = ?
      WHERE
        id = ?
    SQL

    self
  end
end

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

class Reply
  attr_accessor :id, :question_id, :parent_id, :author_id, :body
  
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM replies WHERE id = ?
    SQL
    Reply.new(data.first)
  end
  
  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT * FROM replies WHERE author_id = ?
    SQL
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT * FROM replies WHERE question_id = ?
    SQL
    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @author_id = options['author_id']
    @body = options['body']
  end

  def save
    return update if @id

    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_id, @author_id, @body)
      INSERT
        INTO replies (question_id, parent_id, author_id, body)
      VALUES
        (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id

    self
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    data = QuestionsDatabase.instance.execute(<<-SQL, @parent_id)
      SELECT * FROM replies WHERE id = ?
    SQL

    return nil if data.length.zero?

    Reply.new(data.first)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT * FROM replies WHERE parent_id = ?
    SQL

    return nil if data.length.zero?

    data.map { |datum| Reply.new(datum) }
  end

  private

  def update
    raise 'This record does not exist' unless @id

    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_id, @author_id, @body, @id)
      UPDATE replies
      SET
        question_id = ?,
        parent_id = ?,
        author_id = ?,
        body = ?
      WHERE
        id = ?
    SQL

    self
  end
end

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
