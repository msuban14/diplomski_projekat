class Lecture < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :subject_sub_areas
  has_many :questions, dependent: :destroy
  validates :name , presence: true, length: { maximum: 255 }
  validates :week , presence: true, numericality: { only_integer: true, greater_than: 0 , less_than_or_equal_to: 26 }


  def generatable_questions
    self.questions.where(dependant_question: nil)
  end
end
