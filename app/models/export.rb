class Export
  include ActiveModel::Model


attr_accessor :export_type, :question_areas, :number_of_questions

#validation


APATH = "#{Rails.root}/public/files/export_aiken.txt"

def aiken

  File.delete(APATH) if File.exist?(APATH)

  file = File.open(APATH,"w")
  #TODO testing purposes
  #Question.find_by(question_type_id: 3) do |question|
    question = Question.find_by(question_type_id: 3)
    p "in question************"
    i=65
    correctA = ""
    file.write("#{question.content}")
    question.answers.each do |a|
      file.write("#{i.chr}) #{a.content}")
      if a.isCorrect then correctA=i.chr end
      i = i + 1
    end
    file.write("ANSWER: #{correctA}")
  #end
  file.close
  p "question_end"
end



end
