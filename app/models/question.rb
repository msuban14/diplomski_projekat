class Question < ApplicationRecord
  belongs_to :question_type
  belongs_to :lecture
  belongs_to :question_difficulty
  has_and_belongs_to_many :tags
  #TODO self join
  validates :content, presence: true, length: { maximum: 1024 }

end
