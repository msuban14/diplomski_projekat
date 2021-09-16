class ExportsController < ApplicationController
  def new
    @export = Export.new
  end

  def create
    @export =Export.new(export_params)

    respond_to do |format|
      if @export.valid?
        @export.aiken
        format.html { redirect_to exports_download_path, notice: "Redirected" }
        #format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @import.errors, status: :unprocessable_entity }

      end
    end
  end

  def download
    send_file(
        "#{Rails.root}/public/files/export_aiken.txt",
        filename: "export_aiken.txt",
        type: "application/txt"
      )
  end


  private

  def export_params
    #params.require(:export).permit(:export_type,  :number_of_questions, :question_areas => [])
    params.require(:export).permit(:export_type)
  end
end
