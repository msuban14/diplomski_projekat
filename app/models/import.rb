class Import
  include ActiveModel::Model

  attr_accessor :import_type, :file, :lecture_id
  validates :import_type, presence:true
  validates :file, presence:true
  validates :lecture_id, presence: true

  def import
    #p import_type
    #p '*******************'
    #p file
    #p '*******************'
    #p lecture_id
    if import_type.to_i == 0
      import_aiken(file, lecture_id)
    elsif import_type.to_i == 1
      #import_gift(file, lecture_id)
    else
      #import_xml(file, lecture_id)
    end
  end


  private



  def import_aiken(file, lecture_id)
    #logic for importin aiken

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
        if question.save!
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
          q.content = line
          q.question_type_id = QuestionType.find_by(name: 'multiple choice').id
          q.lecture_id = lecture_id
          q.question_difficulty_id = QuestionDifficulty.find_by(numerical_representation: 0).id
        end
        #question.save!
      else
        #p'answer'
        #a = Answer.new or call class method of Answer p.e. Answer.import
        #help = line.slice!(/[[:upper:]]+\)/)
        answer = Answer.new do |a|
          a.content = line
          a.isCorrect = false
        end
        answers << answer
      end
    end

    f.close
    #p 'file closed'
  end

  def import_gift(file, lecture_id)

  end

  def import_xml(file, lecture_id)

  end
end
