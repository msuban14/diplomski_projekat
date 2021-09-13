class Question < ApplicationRecord
  belongs_to :question_type
  belongs_to :lecture
  belongs_to :question_difficulty
  has_and_belongs_to_many :tags
  has_many :answers, dependent: :destroy
  #self join
  has_many :subquestions, class_name: "Question", foreign_key: "dependant_question_id", dependent: :destroy
  belongs_to :dependant_question, class_name: "Question", optional: true

  validates :content, presence: true, length: { maximum: 4096 }
  #maybe it will slow too much the import
  validates_uniqueness_of :content, scope: %i[question_type_id lecture_id]
  serialize :additional_info


  def to_label
    content.length < 128 ? "#{content}" : "#{content[0..127]...}"
  end



end
