require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params
      .map { |attr, _| "#{attr} = ?" }
      .join(' AND ')
    query = <<-SQL
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL
    results = DBConnection.execute(query, *params.values)
    parse_all(results)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
