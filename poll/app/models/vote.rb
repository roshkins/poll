class Vote < ActiveRecord::Base
  attr_accessible :voter_id, :question_answer_id

  validates :question_answer_id, :presence => true
  #voter id law
  validates :voter_id, :presence => true, :uniqueness => {
    :scope => User.joins(
    'JOIN questionaires on questionaires.author_id = users.id
     JOIN questions ON questions.questionaire_id = questionaires.id
     JOIN question_answers ON questions.id = question_answers.question_id'
     ).where("question_answers.id = ?", :question_answer_id),
    :message => "Each user can only vote on one answer per question." }
  validate :is_author?

  belongs_to :voter,
    :class_name => "User",
    :foreign_key => :voter_id,
    :primary_key => :id

  belongs_to :question_answer,
    :class_name => "QuestionAnswer",
    :foreign_key => :question_answer_id,
    :primary_key => :id

  has_one :question, :through => :question_answer, :source => :question
  has_one :question_author, :through => :question, :source => :author

  def is_author?
     # debugger
    if question.author.id == self.voter_id
      errors.add(:voter_id, "don't vote on your own question")
    end
  end
end
