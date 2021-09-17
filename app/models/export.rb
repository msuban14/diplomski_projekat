class Export
  include ActiveModel::Model


attr_accessor :export_type, :question_areas, :number_of_questions

#validation
validates :export_type, presence:true, numericality: { only_integer: true, greater_than_or_equal_to: 0 , less_than: 2 }
validates :number_of_questions, presence:true, numericality: {only_integer: true}
validates :question_areas, presence:true

APATH = "#{Rails.root}/public/files/export_aiken.txt"
XPATH = "#{Rails.root}/public/files/export_xml.xml"


def export
if export_type.to_i == 0
  export_aiken()
else
  export_xml()
end


#aiken()
end

private

def export_aiken
  lecture_ids = question_areas.reject {|qa| qa.empty? }
  if lecture_ids == nil then lecture_ids = question_areas end

  File.delete(APATH) if File.exist?(APATH)

  file = File.open(APATH,"w")
  #TODO testing purposes
  question_type_id = QuestionType.find_by(name: "multichoice").id
  questions = Question.where(lecture_id: lecture_ids, question_type_id: question_type_id).limit(number_of_questions.to_i)
  questions.each do |question|
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
  lecture_ids = question_areas.reject {|qa| qa.empty? }
  if lecture_ids == nil then lecture_ids = question_areas end

  #File.delete(APATH) if File.exist?(APATH)

  #file = File.open(APATH,"w")
  questions = Question.where(lecture_id: lecture_ids, dependant_question_id: nil).limit(number_of_questions.to_i)

  builder = Nokogiri::XML::Builder.new do |xml|
    xml.quiz {
      questions.each do |q|
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
