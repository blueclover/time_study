class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :prepare_for_mobile

  private
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  def prepare_for_mobile
    request.format = :mobile if mobile_device?
  end
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?

  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      #flash[:alert] = "You must be an admin to do that."
      log_entry = current_user.log_entries.last
      if log_entry
        redirect_to [:edit, log_entry.activity_log, log_entry]
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
