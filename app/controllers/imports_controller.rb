class ImportsController < ApplicationController
  before_action :authenticate_user!
  def new
    @import = Import.new
  end

  def create
    @import =Import.new(import_params)

    respond_to do |format|
      if @import.valid?
        @import.import
        format.html { redirect_to lecture_import_questions_path(import_params[:lecture_id]), notice: "Questions were successfully imported." }
        #format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @import.errors, status: :unprocessable_entity }
        #@import.errors.each {|e| flash.now[:error]="#{e.full_message}"}
        #flash.now[:notice] = "We have exactly #{@books.size} books available."
      end
    end
  end

  private

  def import_params
    params.require(:import).permit(:import_type, :file, :lecture_id)
  end

end
