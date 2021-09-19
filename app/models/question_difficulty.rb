class QuestionDifficulty < ApplicationRecord
  has_many :questions
  validates :name, presence: true, length: { maximum: 255 }
  #validates :numerical_representation, presence: :true,uniqueness: :true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :numerical_representation, presence: :true, numericality: {only_integer: true, greater_than: 0}
end
