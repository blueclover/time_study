class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      moments = current_user.user_moments.active.count
      if moments == 1
        moment = current_user.first_active_moment
        redirect_to new_user_moment_response_path(moment)
      elsif moments > 1
        redirect_to user_moments_path
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
