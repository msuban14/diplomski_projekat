# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



5.times do |i|
  Course.create(name: "Course #{i+1}")
  SubjectArea.create(name: "Subject Area #{i+1}")
  3.times do |j|
    last_id = SubjectArea.last.id.to_i
    SubjectSubArea.create(name: "SubArea #{i*3+j+1}",subject_area_id: last_id)
  end

end
prng = Random.new
200.times do |i|
  tag = Tag.new
  tag.name = "Tag #{i+1}"

  tag.subject_sub_areas << SubjectSubArea.find(SubjectSubArea.pluck(:id).sample(prng.rand(0..5)))

  tag.save
end

Lecture.create(course_id: Course.first.id , name: "Test Aiken", week: 1)
Lecture.create(course_id: Course.first.id , name: "Test XML", week: 2)
Lecture.create(course_id: Course.first.id , name: "Test Lecture 1", week: 3)
Lecture.create(course_id: Course.second.id , name: "Test Lecture 2", week: 1)
10.times do |i|
  lecture = Lecture.new do |l|
    l.course_id = Course.find(Course.pluck(:id)).sample.id
    l.name = "Lecture #{i+1}"
    l.week = i +1
    l.subject_sub_areas << SubjectSubArea.find(SubjectSubArea.pluck(:id).sample(prng.rand(0..2)))
  end
  lecture.save!
end

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

User.create!(email:"admin@admin.com",password: "admin1", password_confirmation: "admin1", admin: true)
User.create!(email:"m@m.com",password: "password1", password_confirmation: "password1")
User.create!(email:"user@user.com",password: "password", password_confirmation: "password")
