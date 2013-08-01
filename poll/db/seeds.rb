# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

fred = User.create!(username: "FredrickWrong", email: "fredis@wrong.com")
joebob = User.create!(username: "JoeBobJoe", email:"joe@bob.joe")

fred.generate_questionaires
joebob.generate_questionaires(1)

joebob.vote_on(fred.questionaires.sample.questions.sample.answers.sample)
fred.vote_on(joebob.questionaires.sample.questions.sample.answers.sample)