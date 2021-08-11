class Course < ApplicationRecord
  has_many :lectures, dependent: :destroy
  validates :name, presence: true , uniqueness: true, length: { maximum: 255 }

end
