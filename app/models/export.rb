class Export
  include ActiveModel::Model


attr_accessor :export_type, :question_areas, :number_of_questions

#validation
validates :export_type, presence:true, numericality: { only_integer: true, greater_than_or_equal_to: 0 , less_than: 2 }
validates :number_of_questions, presence:true, numericality: {only_integer: true, greater_than: 0 }
validates :question_areas, presence:true
validate :number_of_questions_cannot_exceed_total

APATH = Rails.root + "public/export_aiken.txt"
XPATH = Rails.root + "public/export_xml.xml"


def export
  if export_type.to_i == 0
    export_aiken()
  else
    export_xml()
  end
end



private

def number_of_questions_cannot_exceed_total

  lecture_ids = question_areas.reject {|qa| qa.empty? }
  if lecture_ids == nil then lecture_ids = question_areas end

  question_difficulty_id = QuestionDifficulty.find_by(name: "default").id
  if export_type.to_i == 0
    question_type_id = QuestionType.find_by(name: "multichoice").id
    #@questions = Question.where('lecture_id IN (?) AND question_type_id=? AND question_difficulty_id!=?', lecture_ids,question_type_id,question_difficulty_id )
    questions = Question.where(lecture_id: lecture_ids, question_type_id: question_type_id).to_a
  else
    #@questions = Question.where('lecture_id IN (?) AND dependant_question_id IS NULL AND question_difficulty_id!=?', lecture_ids, question_difficulty_id)
    questions = Question.where(lecture_id: lecture_ids, dependant_question_id: nil).to_a
  end

  size = questions.size.to_i

  if size < number_of_questions.to_i
    errors.add(:number_of_questions,"can't be greater than total of questions with assigned difficulties for this course(#{size})")
  else
    generate_test_questions(questions)
  end
end

def calculate_average_difficulty(questions)
  sum=0
  questions.each {|q| sum=sum+q.difficulty}
  sum/questions.size.to_f
end

def calculate_total_difficulty(questions)
  sum = 0
  questions.each {|q| sum=sum+q.difficulty}
  return sum
end

def generate_test_questions(questions_array)
  random_questions = Array.new(number_of_questions.to_i)
  avg = calculate_average_difficulty(questions_array)
  min_target = ((number_of_questions.to_i - avg.to_i * 2) * avg).to_i
  max_target = (number_of_questions.to_i  * avg).ceil.to_i
  random_questions=questions_array.sample(number_of_questions.to_i)
  total_difficulty=calculate_total_difficulty(random_questions)

  #p avg
  #p total_difficulty
  #p min_target..max_target
  #p (min_target..max_target).include?(total_difficulty)

  while (min_target..max_target).include?(total_difficulty) == false
    random_questions.sort_by(&:difficulty)
    #p 'while1 start after sort'
    random_questions.sort! {|a,b| a.difficulty <=> b.difficulty }
    if total_difficulty < min_target
      random_questions.shift
      #p 'shift'
    else
      random_questions.pop
      #p 'pop'
    end

    loop do
      new_q = questions_array.sample
      if !random_questions.include?(new_q) then
        random_questions.append(new_q)
        break
      end
    end

    total_difficulty = calculate_total_difficulty(random_questions)

    #p total_difficulty
    #p min_target..max_target
    #p "while1 end"
  end

  random_questions.each {|q| p "id:#{q.id} diff:#{q.difficulty}"}
  p total_difficulty
  p min_target..max_target
  @questions = random_questions.shuffle
end

def export_aiken

  File.delete(APATH) if File.exist?(APATH)

  file = File.open(APATH,"w")
  @questions.each do |question|
    i=65
    correctA = ""
    file.write("#{question.content}\n")
    question.answers.each do |a|
      file.write("#{i.chr}) #{a.content}\n")
      if a.isCorrect then correctA=i.chr end
      i = i + 1
    end
    file.write("ANSWER: #{correctA}\n")
  end
  file.close

end

def export_xml()
  #TODO add my tags and templates

  builder = Nokogiri::XML::Builder.new do |xml|
    xml.quiz {
      @questions.each do |q|
        xml.question(:type => q.question_type.name) {
          title = nil
          if q.additional_info!= nil and !q.additional_info.empty? then title = q.additional_info["name"] end

          if title != nil
            xml.name {xml.text_ {xml.text title.to_s}}
          else
            xml.name{xml.text_ {xml.cdata q.content}}
          end
          format = q.format
          if format == nil then format="moodle_auto_format" end
          xml.questiontext(:format => format){
            xml.text_{ xml.cdata q.content }
            if q.additional_info!= nil and !q.additional_info.empty?
              file_info = q.additional_info["file"]
              if file_info!=nil
                if !file_info.empty?
                  xml.file(:name => file_info["name"], :path => file_info["path"], :encoding => file_info["encoding"]) {xml.text file_info["text"]}
                end
              end
            end
          }#questiontext
          if q.additional_info!= nil and !q.additional_info.empty?
            q.additional_info.each do |key,value|
              if key != "name" and key != "file"
                if key.match?(/feedback|graderinfo|responsetemplate/)
                  xml.method_missing(key,:format => format){ xml.text_ {xml.text value}}
                else
                  xml.method_missing(key){ xml.text value }
                end
              end
            end
          end
          if q.question_type == "matching"
            q.subquestions.each do |sq|
              xml.subquestion(:format => format) {
                xml.text_ {xml.cdata sq.content}
                xml.answer {xml.text_ {xml.cdata sq.answer.content}}
              }#subquestion
            end
          elsif q.answers != nil
            q.answers.each do |a|
              fraction = a.isCorrect ? 100:0
              xml.answer(:fraction => fraction, :format => format){
                xml.text_ {xml.cdata a.content}
                if a.additional_info != nil and !a.additional_info.empty?
                  a.additional_info.each do |key,value|
                    if key.match?(/feedback/)
                      xml.method_missing(key,:format => format){ xml.text_ {xml.text value}}
                    else
                      xml.method_missing(key){ xml.text value }
                    end
                  end
                end
              }#answer
            end
          else
            #do nothing
          end
        }#question
      end
    }#quiz
  end
  File.delete(XPATH) if File.exist?(XPATH)

  file = File.open(XPATH,"w")
  file.write(builder.to_xml)
  file.close
end



end
