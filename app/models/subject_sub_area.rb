class SubjectSubArea < ApplicationRecord
  belongs_to :subject_area
  has_and_belongs_to_many :lectures
  has_and_belongs_to_many :tags
  validates :name, presence: true, length: { maximum: 255 }


  def lecture_ids
    ret_a = Array.new
    lectures.each {|l| ret_a.append(l.id)}
    p "lecture_ids #{ret_a}"
    return ret_a
  end
end
