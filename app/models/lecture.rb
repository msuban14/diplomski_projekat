class Lecture < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :subject_sub_areas
end
