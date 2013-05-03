class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def authorize_admin!
      authenticate_user!
      unless current_user.admin?
        #flash[:alert] = "You must be an admin to do that."
        log = current_user.activity_logs.first
        if log
          redirect_to [log.survey, log]
        else
          survey = Survey.find_by_county_id(current_user.county_id)
          if survey
            redirect_to new_survey_activity_log_path(survey)
          else
            sign_out(current_user)
            flash[:notice] = "Your county does not have any active surveys."
            redirect_to new_user_session_path
          end
        end
      end
    end
end
