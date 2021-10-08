class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /lectures or /lectures.json
  def index
    @lectures = Lecture.paginate(page: params[:page], :per_page => 30)
  end

  # GET /lectures/1 or /lectures/1.json
  def show
    #@questions = Question.where(lecture_id: @lecture.id).paginate(page: params[:page], :per_page => 50)
    @questions = @lecture.questions.where(dependant_question: nil).paginate(page: params[:page], :per_page => 30)
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
  end

  # GET /lectures/1/edit
  def edit
  end

  # POST /lectures or /lectures.json
  def create
    @lecture = Lecture.new(lecture_params)

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to @lecture, notice: "Lecture was successfully created." }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1 or /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to @lecture, notice: "Lecture was successfully updated." }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1 or /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: lectures_url, notice: "Lecture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lecture_params
      params.require(:lecture).permit(:name, :week, :course_id, :subject_sub_area_ids => [])
    end
end
