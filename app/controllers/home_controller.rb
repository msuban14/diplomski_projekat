class HomeController < ApplicationController

  def index
    if current_user != nil
      if current_user.admin
        redirect_to rails_admin_path
      else
        redirect_to imports_path
      end
    else
      redirect_to new_user_session_path
    end
  end
end
