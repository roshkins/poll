class QuestionAnswer < ActiveRecord::Base
  attr_accessible :answer, :question_id
  belongs_to :question,
    :class_name => "Question",
    :foreign_key => :question_id,
    :primary_key => :id

  has_many :votes,
    :class_name => "Vote",
    :foreign_key => :question_answer_id,
    :primary_key => :id

  has_many :voters,
    :through => :votes,
    :source => :voter

  def self.random_answer
    answer = QuestionAnswer.create!
    answer.answer = ["Because", "France", "That's just the way it is.",
      "That's what she said.", "Because God.",
      "Where am I? How did I get here? Who are you?", "I told you so.",
      "That question is invalid.", "You raise a good point.", "Because Ned.",
      "The Internet!", "You just asked that to show how smart you are."].sample
    answer.save!
    answer
  end

end
