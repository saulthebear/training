require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    data = PlayDBConnection.instance.execute(<<-SQL, title)
        SELECT * FROM plays WHERE title = ?
    SQL
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_playwright(name)
    data = PlayDBConnection.instance.execute(<<-SQL, name)
        SELECT
          *
        FROM
          plays
        JOIN
          playwrights ON plays.playwright_id = playwrights.id
        WHERE
          playwrights.name = ?
    SQL
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  attr_accessor :name, :birth_year

  def self.all
    data = PlayDBConnection.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        playwrights
    SQL
    data.map { |datum| Playwright.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise ArgumentError, "#{self} is already in the database" if @id

    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL

    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise ArgumentError, "#{self} is not in the database" unless @id

    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?,
        birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    raise ArgumentError, "#{self} is not in the database" unless @id

    plays_data = PlayDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        plays.id, plays.title, plays.year, plays.playwright_id
      FROM
        plays
      JOIN
        playwrights ON plays.playwright_id = playwrights.id
      WHERE
        playwrights.id = ?
    SQL
    
    plays_data.map do |play_data|
      Play.new(play_data)
    end
  end
end
