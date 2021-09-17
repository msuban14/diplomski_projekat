class ExportsController < ApplicationController
  def new
    @export = Export.new
    #@course = Course.first
  end

  def create
    @export =Export.new(export_params)

    respond_to do |format|
      if @export.valid?
        @export.export
        if @export.export_type == 1
          format.html { redirect_to exports_download_aiken_path }
        else
          format.html { redirect_to exports_download_xml_path }
        end

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @import.errors, status: :unprocessable_entity }

      end
    end
  end

  def download_aiken
    send_file(
        "#{Rails.root}/public/files/export_aiken.txt",
        filename: "export_aiken.txt",
        type: "application/txt"
      )
      #redirect_to exports_path
  end

  def download_xml
    send_file(
        "#{Rails.root}/public/files/export_xml.xml",
        filename: "export_xml.xml",
        type: "application/xml"
      )
      #redirect_to exports_path
  end


  private

  def export_params
    params.require(:export).permit(:export_type,  :number_of_questions, :question_areas => [])
    #params.require(:export).permit(:export_type)
  end
end
