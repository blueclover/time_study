class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def authorize_admin!
      authenticate_user!
      unless current_user.admin?
        #flash[:alert] = "You must be an admin to do that."
        moment = current_user.user_moments.first
        if moment
          response = moment.response
          if response
            redirect_to [moment,response]
          else
            redirect_to new_user_moment_response_path(moment)
          end
        else
          survey = Survey.find_by_county_id(current_user.county_id)
          if survey
            sign_out(current_user)
            flash[:notice] = "You have not been selected to participate in any surveys."
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
