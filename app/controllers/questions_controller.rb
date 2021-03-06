class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :is_admin!,  only: [ :new ]

  # GET /questions or /questions.json
  def index
    @questions = Question.where(dependant_question: nil).paginate(page: params[:page], :per_page => 50)
  end

  # GET /questions/1 or /questions/1.json
  def show
    if @question.question_type.name == "matching" and @question.dependant_question== nil
      @questions = @question.subquestions
    end

    if @question.answers.any?
      @answers = @question.answers
    end
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def lectures
    @questions = Question.where(lecture_id: params[:id], dependant_question: nil).order(created_at: :desc)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:content, :question_type_id, :lecture_id, :question_difficulty_id, :tag_ids => [])
    end


end
