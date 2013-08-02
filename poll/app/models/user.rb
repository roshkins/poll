class User < ActiveRecord::Base
  attr_accessible :username, :email
  has_many :questionaires,
    :class_name => "Questionaire",
    :foreign_key => :author_id,
    :primary_key => :id

  has_many :votes,
    :class_name => "Vote",
    :foreign_key => :voter_id,
    :primary_key => :id

  def generate_questionaires(num = 5)
    num.times{ self.questionaires << (Questionaire.random_questionaire) }
    save!
  end

  def vote_on(answer)
    votes.create!(question_answer_id: answer.id)
  end

  def create_questionaire(question_answer_hash)
    b = Questionaire.create!(author_id: @id)
    self.questionaires << b
    question_answer_hash.each do |question, answer_array|
      b.questions << (q = Question.create!(question: question))
      answer_array.each do |answer|
        q.answers << QuestionAnswer.create!(answer: answer)
      end
    end
  end

  def questionaire_responses
    poll_results = {}
    q = questionaires.includes(:questions => [:answers =>[:votes]])
    q.each do |questionaire|
      results = {}
      questionaire.questions.each do |question|
        r = Hash.new(0)
        question.answers.each{ |answer| r[answer] = answer.votes.length }
        results[question] = r
      end
      poll_results[questionaire] = results
    end
    poll_results
  end
end
