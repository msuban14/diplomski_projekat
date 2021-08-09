class Question < ApplicationRecord
  belongs_to :question_type
  belongs_to :lecture
  belongs_to :question_difficulty
  has_and_belongs_to_many :tags
end
