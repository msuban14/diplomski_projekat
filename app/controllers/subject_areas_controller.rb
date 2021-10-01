class SubjectAreasController < ApplicationController
  before_action :set_subject_area, only: %i[ show edit update destroy ]

  # GET /subject_areas or /subject_areas.json
  def index
    @subject_areas = SubjectArea.paginate(page: params[:page], :per_page => 30)
  end

  # GET /subject_areas/1 or /subject_areas/1.json
  def show
      @subject_sub_areas=SubjectSubArea.where(subject_area_id: @subject_area.id)
  end

  # GET /subject_areas/new
  def new
    @subject_area = SubjectArea.new
  end

  # GET /subject_areas/1/edit
  def edit
  end

  # POST /subject_areas or /subject_areas.json
  def create
    @subject_area = SubjectArea.new(subject_area_params)

    respond_to do |format|
      if @subject_area.save
        format.html { redirect_to @subject_area, notice: "Subject area was successfully created." }
        format.json { render :show, status: :created, location: @subject_area }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subject_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subject_areas/1 or /subject_areas/1.json
  def update
    respond_to do |format|
      if @subject_area.update(subject_area_params)
        format.html { redirect_to @subject_area, notice: "Subject area was successfully updated." }
        format.json { render :show, status: :ok, location: @subject_area }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subject_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subject_areas/1 or /subject_areas/1.json
  def destroy
    @subject_area.destroy
    respond_to do |format|
      format.html { redirect_to subject_areas_url, notice: "Subject area was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject_area
      @subject_area = SubjectArea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subject_area_params
      params.require(:subject_area).permit(:name)
    end
end
