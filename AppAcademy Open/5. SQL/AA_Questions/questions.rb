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
  attr_accessor :fname, :lname

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
    Users.new(data.first)
  end
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
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

  def initialize(options)
    @id = options['id']
    @author_id = options['author_id']
    @title = options['title']
    @body = options['body']
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
  
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @author_id = options['author_id']
    @body = options['body']
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
  
  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
