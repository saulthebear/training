require_relative 'import_questions_classes'

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
