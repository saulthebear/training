require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns unless @columns.nil?
    results = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT 1
    SQL

    @columns = results[0].map(&:to_sym)
  end

  def self.finalize!
    # Call attributes method to initialize the instance variable
    # attributes    

    self.columns.each do |column|
      define_method(column) do
        attributes[column]
      end

      define_method("#{column}=") do |val|
        attributes[column] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    query = <<-SQL
      SELECT *
      FROM #{self.table_name}
    SQL

    results = DBConnection.execute(query)
    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map do |result|
      self.new(result)
    end
  end

  def self.find(id)
    # query = 
    results = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{self.table_name}
      WHERE #{self.table_name}.id == ?
      LIMIT 1
    SQL

    results.length == 1 ? self.new(results[0]) : nil
  end

  def initialize(params = {})
    valid_attrs = self.class.columns
    params.each do |attr_name, val|
      raise "unknown attribute '#{attr_name}'" unless valid_attrs.include?(attr_name.to_sym)
      self.send("#{attr_name}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |col_name|
      attributes[col_name]
    end
  end

  def insert
    comma_seperated_columns = self.class.columns.join(', ')
    questionmark_array = ['?'] * self.class.columns.length
    comma_seperated_questionmarks = questionmark_array.join(', ')
    query = <<-SQL
      INSERT INTO
        #{self.class.table_name} (#{comma_seperated_columns})
      VALUES
        (#{comma_seperated_questionmarks})
    SQL
    DBConnection.execute(query, attribute_values)
    self.id = DBConnection.last_insert_row_id
  end

  def update
    columns_row = self.class.columns
      .map { |attr| "#{attr} = ?" }
      .join(', ')
    query = <<-SQL
      UPDATE
        #{self.class.table_name}
      SET
        #{columns_row}
      WHERE
        id = ?
    SQL
    DBConnection.execute(query, attribute_values, self.id)
  end

  def save
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end
end
