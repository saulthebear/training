require_relative 'import_questions_classes'

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
