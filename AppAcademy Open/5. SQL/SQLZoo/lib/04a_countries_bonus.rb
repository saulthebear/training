# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (SELECT MAX(gdp) FROM countries WHERE continent = 'Europe')
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
  SELECT
    continent,
    name,
    area
  FROM
    countries
  WHERE
    (continent, area)
      IN
      (
        SELECT continent, MAX(area)
        FROM countries
        GROUP BY continent
      )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      a.name,
      a.continent
    FROM
      countries a
    WHERE
      a.population > 3 * (
        SELECT
          MAX(b.population)
        FROM
          countries b
        WHERE
          b.name != a.name
          AND
          b.continent = a.continent
      )
  SQL
end
