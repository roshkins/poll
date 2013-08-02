class Question < ActiveRecord::Base
  attr_accessible :question, :questionaire_id

  belongs_to :questionaire,
    :class_name => "Questionaire",
    :foreign_key => :questionaire_id,
    :primary_key => :id

  has_many :answers,
    :class_name => "QuestionAnswer",
    :foreign_key => :question_id,
    :primary_key => :id

  has_many :votes,
    :through => :answers,
    :source => :votes

  has_many :respondents,
    :through => :answers,
    :source => :voters

  has_one :author,
    :through => :questionaire,
    :source => :user

  def results
    results = Hash.new(0)
    responses = self.answers.includes(:votes)
    responses.each{ |answer| results[answer] = answer.votes.length }
    results
  end

  def self.random_question(num = 5)
    question = Question.new(:question => %w(who what where when why).sample\
      + " " + %w(does do is was can could).sample + " " +\
         %w(apple Sam table friends hands time children).sample + " " +\
         %w(fly time run steal fetch kvetch kidnap).sample + "?")
    question.save!
    num.times { question.answers << QuestionAnswer.random_answer }
    question
  end
end
