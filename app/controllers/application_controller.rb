class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def authorize_admin!
      authenticate_user!
      unless current_user.admin?
        #flash[:alert] = "You must be an admin to do that."
        log = current_user.activity_logs.first
        redirect_to [log.survey, log]
      end
    end
end
