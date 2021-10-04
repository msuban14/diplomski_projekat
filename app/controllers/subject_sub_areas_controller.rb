class SubjectSubAreasController < ApplicationController
  before_action :set_subject_sub_area, only: %i[ show edit update destroy ]

  # GET /subject_sub_areas or /subject_sub_areas.json
  def index
    @subject_sub_areas = SubjectSubArea.paginate(page: params[:page], :per_page => 30)
  end

  # GET /subject_sub_areas/1 or /subject_sub_areas/1.json
  def show
    @lectures = @subject_sub_area.lectures
  end

  # GET /subject_sub_areas/new
  def new
    @subject_sub_area = SubjectSubArea.new
  end

  # GET /subject_sub_areas/1/edit
  def edit
  end

  # POST /subject_sub_areas or /subject_sub_areas.json
  def create
    @subject_sub_area = SubjectSubArea.new(subject_sub_area_params)

    respond_to do |format|
      if @subject_sub_area.save
        format.html { redirect_to @subject_sub_area, notice: "Subject sub area was successfully created." }
        format.json { render :show, status: :created, location: @subject_sub_area }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subject_sub_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subject_sub_areas/1 or /subject_sub_areas/1.json
  def update
    respond_to do |format|
      if @subject_sub_area.update(subject_sub_area_params)
        format.html { redirect_to @subject_sub_area, notice: "Subject sub area was successfully updated." }
        format.json { render :show, status: :ok, location: @subject_sub_area }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subject_sub_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subject_sub_areas/1 or /subject_sub_areas/1.json
  def destroy
    @subject_sub_area.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: subject_sub_areas_url, notice: "Subject sub area was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject_sub_area
      @subject_sub_area = SubjectSubArea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subject_sub_area_params
      params.require(:subject_sub_area).permit(:name, :subject_area_id, :lecture_ids => [], :tag_ids => [])
    end
end
