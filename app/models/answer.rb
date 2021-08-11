class Answer < ApplicationRecord
  belongs_to :question
  validates :content, presence: true, length: { maximum: 1024 }
  validates :is_correct, exclusion: [nil]
end
