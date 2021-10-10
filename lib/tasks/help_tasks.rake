task :randomize_diff => :environment do
  qdiff = QuestionDifficulty.find_by(name: "default").id
  q_diff_a = QuestionDifficulty.where.not(id: qdiff).to_a
  Question.where(question_difficulty_id: qdiff).each do |q|
    new_diff = q_diff_a.sample.id
    q.question_difficulty_id = new_diff
    q.save
  end
end

task :add_tags => :environment do
  prng = Random.new
  Question.where.missing(:tags).each do |q|
    q.tags << Tag.find(Tag.pluck(:id).sample(prng.rand(0..5)))
    q.save
  end
end
