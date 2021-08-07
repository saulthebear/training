# https://open.appacademy.io/learn/full-stack-online/intro-to-programming/hand-score
# Write a method hand_score that takes in a string representing a hand of cards and returns it's total score. You can
# assume the letters in the string are only A, K, Q, J. A is worth 4 points, K is 3 points, Q is 2 points, and J is 1
# point. The letters of the input string not necessarily uppercase.

def hand_score(hand)
  scores = {
    'A' => 4,
    'K' => 3,
    'Q' => 2,
    'J' => 1
  }
  hand_score = 0
  hand.upcase.each_char do |card|
    hand_score += scores[card]
  end
  return hand_score
end

puts hand_score("AQAJ") #=> 11
puts hand_score("jJka") #=> 9
