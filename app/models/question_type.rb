class QuestionType < ApplicationRecord
  has_many :questions
  validates :name, presence: true, length: { maximum: 255 }
end
