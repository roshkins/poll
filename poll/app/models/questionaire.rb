class Questionaire < ActiveRecord::Base
  attr_accessible :author_id
  belongs_to :user,
    :class_name => "User",
    :foreign_key => :author_id,
    :primary_key => :id

  has_many :questions,
    :class_name => "Question",
    :foreign_key => :questionaire_id,
    :primary_key => :id

  has_many :votes,
    :through => :questions,
    :source  => :votes

  def self.random_questionaire(num = 5)
    questionaire = Questionaire.create!
    num.times{ questionaire.questions << (Question.random_question) }
    questionaire
  end

  def results
    results = Hash.new(0)
    q = questions.includes(:answers =>[:votes])
    q.each do |question|
      r = Hash.new(0)
      question.answers.each{ |answer| r[answer] = answer.votes.length }
      results[question] = r
    end
    results
  end
end
