class Answer < ApplicationRecord
  belongs_to :question
  validates :content, presence: true, length: { maximum: 1024 }
  validates :is_correct, exclusion: [nil]


  def to_label
    content.length < 128 ? "#{content}" : "#{content[0..127]...}"
  end
end
