class ApplicationController < ActionController::Base
  helper_method :is_admin!

  private
  def is_admin!
    unless current_user and current_user.admin
      #redirect_to root_path,  alert: 'Your account does not have access to this page!'
      respond_to do |format|
        format.html do
          flash[:danger] = "Your account does not have access to this page!"
          redirect_back fallback_location: root_path
        end
        format.json { render  message: "Please log in as admin", status: :forbidden }
      end
    end
  end
end
