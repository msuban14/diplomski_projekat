class Import
  include ActiveModel::Model

  attr_accessor :import_type, :file, :lecture_id
  validates :import_type, presence:true, numericality: { only_integer: true, greater_than_or_equal_to: 0 , less_than: 2 }
  validates :file, presence:true
  validates :lecture_id, presence: true

  def import
    if import_type.to_i == 0
      import_aiken(file, lecture_id)
    else
      import_xml(file, lecture_id)
    end
  end


  private



  def import_aiken(file, lecture_id)
    #logic for importin aiken
    #only multichoice for aiken format
    question_type = QuestionType.find_by(name: 'multichoice').id
    question_difficulty=QuestionDifficulty.find_by(name: 'default').id
    answers = Array.new
    question = Question.new
    answer = Answer.new
    #question = Question.new
    f = File.open(file)
    File.foreach(f) do |line|
     #puts line

      if line.start_with?("ANSWER:")
        #p line
        #logic here to start anew
        line.slice!("ANSWER:")
        line.strip
        #correctA = line
        if question.save
          answers.each do |a|
            a.question_id = question.id
            ano = a.content.slice!((/[[:upper:]]+\)/))
            ano.slice!(/\)/)
            #p ano +'*******************'+line.chomp.strip
            if ano.strip == line.chomp.strip
              a.isCorrect=true
            end
            #p a
            a.save
          end
        end
        answers.clear
      elsif line.match(/[[:upper:]]+\)/) == nil

        question = Question.new do |q|
          q.content = line.chomp.strip
          q.question_type_id = question_type
          q.lecture_id = lecture_id
          q.question_difficulty_id = question_difficulty
        end
      else
        answer = Answer.new do |a|
          a.content = line.chomp.strip
          a.isCorrect = false
        end
        answers << answer
      end
    end
    answers.clear
    f.close
  end


  def import_xml(file, lecture_id)
    question_diff = QuestionDifficulty.find_by(name: "default").id
    questionTypes = Hash.new
    QuestionType.all.each {|qt| questionTypes[qt.name.to_s] = qt.id}

    questionDetails=Hash.new
    answerDetails = Hash.new
    file_details = Hash.new


    f = File.open(file)
    doc = Nokogiri::XML(f)
    file.close

    doc.css('question').each do |tag|
      question = Question.new
      questionType = tag.attributes["type"].value
      #skip category
      if questionType == "category"
        next
      end
      #question.question_type_id = QuestionType.find_by(name: questionType).id
      question.question_type_id = questionTypes[questionType.to_s]
      tag.children.each do |t|
        if t.name == "questiontext"
          question.format =  t.attributes["format"].value
          question.content = t.css('text').inner_text

          #check if file is attached
          f_elem = t.css('file')[0]
          if f_elem != nil
            f_elem.attributes.each {|attr| file_details[attr[1].name] = attr[1].value }
            file_details["text"] = f_elem.inner_text
            questionDetails["file"] = file_details
          end
        end

        if t.name != "text" and t.name !="questiontext" and t.name !="answer" and t.name !="subquestion"
          questionDetails[t.name.to_s] = t.inner_text.chomp.strip
        end
      end
      question.lecture_id = lecture_id
      question.question_difficulty_id = question_diff
      question.additional_info = questionDetails

      #answer = Answer.new
      #save question - without raising an exception
      if  question.save and questionType != "essay" and questionType != "cloze"
        #search answers

        if questionType != "matching"
          tag.css('answer').each do |a|
            answer = Answer.new
            answer.content = a.inner_text.chomp.strip
            answer.isCorrect = (a.attributes["fraction"].value.to_i > 0)
            a.children.each do |achild|
              if achild.name != "text" and achild.element?
              #if achild.element?
                answerDetails[achild.name.to_s] = achild.inner_text.chomp.strip
              end
            end
            answer.additional_info = answerDetails
            answer.question_id = question.id
            answer.save
            answerDetails.clear
          end
        else
          subquestion = Question.new
          tag.css('subquestion').each do |sq|
            sq.children.each do |sqchild|
              if sqchild.element?
                if sqchild.name == "text"
                  #subquestion
                  #p "subquestion : #{sqchild.inner_text.chomp.strip}"
                  subquestion = Question.new do |subq|
                    subq.question_type_id = question.question_type_id
                    subq.lecture_id = lecture_id
                    subq.question_difficulty_id = question_diff
                    subq.dependant_question_id = question.id
                    subq.format = question.format
                    subq.content = sqchild.inner_text.chomp.strip
                  end
                  subquestion.save
                elsif sqchild.name == "answer"
                  p "answer : #{sqchild.inner_text.chomp.strip}"
                  answer = Answer.new do |a|
                    a.isCorrect = true
                    a.content = sqchild.inner_text.chomp.strip
                    a.question_id = subquestion.id
                  end
                  answer.save
                else
                  #answerDetails[sqchild.name.to_s] = sqchild.inner_text.chomp.strip
                end #name
              end #elem
            end #sqchild
          end #sq

          #answerDetails.clear
        end
      end
      file_details.clear
      questionDetails.clear
    end #doc loop
  end
end
