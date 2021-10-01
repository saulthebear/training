def initialize(name, breed, age, bark, favorite_foods)
  @name = name
  @breed = breed
  @age = age
  @bark = bark
  @favorite_foods = favorite_foods
end

# Getters
def name
  @name
end

def breed
  @breed
end

def age
  @age
end

def bark
  return @bark.upcase if @age > 3

  @bark.downcase
end

def favorite_foods
  @favorite_foods
end

# Setters
def age=(age)
  @age = age
end

# Methods
def favorite_food?(food)
  @favorite_foods.map(&:downcase).include?(food.downcase)
end