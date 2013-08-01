class Vote < ActiveRecord::Base
  attr_accessible :voter_id, :question_answer_id

  validates :question_answer_id, :presence => true
  #voter id law
  validates :voter_id, :presence => true, :uniqueness => { :scope => :question,
    :message => "Each user can only vote on one answer per question." },
    unless: :is_author?

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
    question_author.id == self.voter_id
  end
end
