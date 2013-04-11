class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def authorize_admin!
      authenticate_user!
      unless current_user.admin?
        #flash[:alert] = "You must be an admin to do that."
        moment = current_user.first_active_moment
        if moment
          redirect_to new_user_moment_response_path(moment)
        else
          survey = Survey.find_by_county_id(current_user.county_id)
          if survey
            sign_out(current_user)
            flash[:notice] = "You do not have any active moments to respond to."
            redirect_to new_user_session_path
          else
            sign_out(current_user)
            flash[:notice] = "Your county does not have any active surveys."
            redirect_to new_user_session_path
          end
        end
      end
    end
end
