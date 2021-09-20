# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



2.times do |i|
  Course.create(name: "Course #{i+1}")
  SubjectArea.create(name: "Subject Area #{i+1}")
  2.times do |j|
    last_id = SubjectArea.last.id.to_i
    SubjectSubArea.create(name: "Subject #{last_id} SubArea #{j+1}",subject_area_id: last_id)
  end

end

3.times do |i|
  Tag.create(name: "Tag #{i+1}")
end

Lecture.create(course_id: 1 , name: "Test Aiken", week: 1)
Lecture.create(course_id: 1 , name: "Test XML", week: 2)
Lecture.create(course_id: 1 , name: "Lecture 3", week: 3)
Lecture.create(course_id: 2 , name: "Test Lecture", week: 1)

# MUST HAVE!
QuestionType.create(name: "multichoice")
QuestionType.create(name: "truefalse")
QuestionType.create(name: "shortanswer")
QuestionType.create(name: "matching")
QuestionType.create(name: "essay")
QuestionType.create(name: "numerical")
QuestionType.create(name: "cloze")

QuestionDifficulty.create(name: "default", numerical_representation: 1)
QuestionDifficulty.create(name: "easy", numerical_representation: 1)
QuestionDifficulty.create(name: "medium", numerical_representation: 2)
QuestionDifficulty.create(name: "hard", numerical_representation: 3)
