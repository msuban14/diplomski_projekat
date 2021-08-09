class SubjectSubArea < ApplicationRecord
  belongs_to :subject_area
  has_and_belongs_to_many :lectures
  has_and_belongs_to_many :tags
end
