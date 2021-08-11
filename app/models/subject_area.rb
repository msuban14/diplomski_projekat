class SubjectArea < ApplicationRecord
  has_many :subject_sub_areas
  validates :name, presence: true, length: { maximum: 255 }
end
