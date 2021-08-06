class QuestionDifficultiesController < ApplicationController
  before_action :set_question_difficulty, only: %i[ show edit update destroy ]

  # GET /question_difficulties or /question_difficulties.json
  def index
    @question_difficulties = QuestionDifficulty.all
  end

  # GET /question_difficulties/1 or /question_difficulties/1.json
  def show
  end

  # GET /question_difficulties/new
  def new
    @question_difficulty = QuestionDifficulty.new
  end

  # GET /question_difficulties/1/edit
  def edit
  end

  # POST /question_difficulties or /question_difficulties.json
  def create
    @question_difficulty = QuestionDifficulty.new(question_difficulty_params)

    respond_to do |format|
      if @question_difficulty.save
        format.html { redirect_to @question_difficulty, notice: "Question difficulty was successfully created." }
        format.json { render :show, status: :created, location: @question_difficulty }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question_difficulty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_difficulties/1 or /question_difficulties/1.json
  def update
    respond_to do |format|
      if @question_difficulty.update(question_difficulty_params)
        format.html { redirect_to @question_difficulty, notice: "Question difficulty was successfully updated." }
        format.json { render :show, status: :ok, location: @question_difficulty }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question_difficulty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_difficulties/1 or /question_difficulties/1.json
  def destroy
    @question_difficulty.destroy
    respond_to do |format|
      format.html { redirect_to question_difficulties_url, notice: "Question difficulty was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_difficulty
      @question_difficulty = QuestionDifficulty.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_difficulty_params
      params.require(:question_difficulty).permit(:name, :numerical_representation)
    end
end
