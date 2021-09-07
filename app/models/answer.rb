class Answer < ApplicationRecord
  belongs_to :question
  validates :content, presence: true, length: { maximum: 1024 }
  validates :isCorrect, exclusion: [nil]

  serialize :additional_info


  def to_label
    content.length < 128 ? "#{content}" : "#{content[0..127]...}"
  end
end
