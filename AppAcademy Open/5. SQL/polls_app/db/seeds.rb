# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  { username: 'SaulTheBear' },
  { username: 'Bodhi' },
  { username: 'George' },
  { username: 'Max' },
  { username: 'Kate' },
  { username: 'Jack' },
  { username: 'Sawyer' },
  { username: 'Hurley' },
  { username: 'Sayid' },
  { username: 'Boon' }
])

polls = Poll.create([
  { author: users[0], title: 'Poll 1' },
  { author: users[0], title: 'Poll 2' },
  { author: users[0], title: 'Poll 3' },
  { author: users[1], title: 'Poll 4' },
  { author: users[2], title: 'Poll 5' },
  { author: users[3], title: 'Poll 6' },
  { author: users[4], title: 'Poll 7' },
  { author: users[5], title: 'Poll 8' },
  { author: users[6], title: 'Poll 9' },
  { author: users[7], title: 'Poll 10' },
  { author: users[8], title: 'Poll 11' },
  { author: users[9], title: 'Poll 12' },
  { author: users[5], title: 'Poll 13' },
  { author: users[6], title: 'Poll 14' },
  { author: users[7], title: 'Poll 15' },
  { author: users[0], title: 'Favorites' }
])

questions = Question.create([
  { poll: polls[0], text: 'Q1' },
  { poll: polls[0], text: 'Q2' },
  { poll: polls[0], text: 'Q3' },
  { poll: polls[1], text: 'Q1' },
  { poll: polls[1], text: 'Q2' },
  { poll: polls[1], text: 'Q3' },
  { poll: polls[2], text: 'Q1' },
  { poll: polls[2], text: 'Q1' },
  { poll: polls[2], text: 'Q1' },
  { poll: polls[3], text: 'Q2' },
  { poll: polls[3], text: 'Q3' },
  { poll: polls[3], text: 'Q1' },
  { poll: polls[4], text: 'Q2' },
  { poll: polls[4], text: 'Q3' },
  { poll: polls[4], text: 'Q1' },
  { poll: polls[5], text: 'Q2' },
  { poll: polls[5], text: 'Q3' },
  { poll: polls[5], text: 'Q1' },
  { poll: polls[6], text: 'Q2' },
  { poll: polls[6], text: 'Q3' },
  { poll: polls[6], text: 'Q1' },
  { poll: polls[7], text: 'Q2' },
  { poll: polls[7], text: 'Q3' },
  { poll: polls[7], text: 'Q1' },
  { poll: polls[8], text: 'Q2' },
  { poll: polls[8], text: 'Q3' },
  { poll: polls[8], text: 'Q1' },
  { poll: polls[15], text: "Who's your favorite cat?"}
])

answer_choices = AnswerChoice.create([
  { question: questions[0], text: 'A' },
  { question: questions[0], text: 'B' },
  { question: questions[0], text: 'C' },
  
  { question: questions[1], text: 'A' },
  { question: questions[1], text: 'B' },
  { question: questions[1], text: 'C' },
  
  { question: questions[2], text: 'A' },
  { question: questions[2], text: 'B' },
  { question: questions[2], text: 'C' },
  
  { question: questions[3], text: 'A' },
  { question: questions[3], text: 'B' },
  { question: questions[3], text: 'C' },
  
  { question: questions[4], text: 'A' },
  { question: questions[4], text: 'B' },
  { question: questions[4], text: 'C' },

  { question: questions[27], text: 'Earl' },
  { question: questions[27], text: 'Breakfast' },
  { question: questions[27], text: 'Maru' }

])

earl = answer_choices[15]
breakfast = answer_choices[16]
maru = answer_choices[17]

Response.create([
  { respondent: users[0], answer_choice: answer_choices[0] },
  { respondent: users[0], answer_choice: answer_choices[4] },
  { respondent: users[0], answer_choice: answer_choices[8] },
  { respondent: users[0], answer_choice: answer_choices[9] },
  { respondent: users[0], answer_choice: answer_choices[13] },

  { respondent: User.find_by(username: 'Bodhi'), answer_choice: earl },
  { respondent: User.find_by(username: 'George'), answer_choice: earl },
  { respondent: User.find_by(username: 'Max'), answer_choice: earl },

  { respondent: User.find_by(username: 'Kate'), answer_choice: breakfast },
  { respondent: User.find_by(username: 'Jack'), answer_choice: breakfast },
  { respondent: User.find_by(username: 'Sawyer'), answer_choice: breakfast },
  { respondent: User.find_by(username: 'Hurley'), answer_choice: breakfast },

  { respondent: User.find_by(username: 'Sayid'), answer_choice: maru },
  { respondent: User.find_by(username: 'Boon'), answer_choice: maru }
])
