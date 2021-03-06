class Tag < ApplicationRecord
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :subject_sub_areas
  validates :name, presence: true, length: { maximum: 255 }
end
