class ExportsController < ApplicationController
before_action :authenticate_user!


  def showall
    @courses = Course.all
  end

  def new
    @export = Export.new
    @course = Course.find(params[:id])
  end

  def create
    @export =Export.new(export_params)
    #course_id =params.require(:export).permit(:course_id)


    @course = Course.find(@export.course_id.to_i)

    respond_to do |format|
      if @export.valid?
        @export.export
        if @export.export_type.to_i == 0
          format.html { redirect_to exports_download_aiken_path }
        else
          format.html { redirect_to exports_download_xml_path }
        end

      else
        #format.html { render :new,:location => export_path(@course), status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }

        format.json { render json: @import.errors, status: :unprocessable_entity }

      end
    end
  end

  def download_aiken
    send_file(
        Rails.root + "public/export_aiken.txt",
        filename: "export_aiken.txt",
        type: "application/txt"
      )
  end

  def download_xml
    send_file(
        Rails.root + "public/export_xml.xml",
        filename: "export_xml.xml",
        type: "application/xml"
      )
  end


  private

  def export_params
    params.require(:export).permit(:export_type,:course_id, :select_type ,:number_of_questions, :question_lectures => [], :question_areas => [], :question_sub_areas => [])
    #params.require(:export).permit(:export_type)
  end
end
