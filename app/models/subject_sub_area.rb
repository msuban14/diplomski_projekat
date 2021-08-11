class SubjectSubArea < ApplicationRecord
  belongs_to :subject_area
  has_and_belongs_to_many :lectures
  has_and_belongs_to_many :tags
  validates :name, presence: true, length: { maximum: 255 }
end
