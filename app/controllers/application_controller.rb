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
    # true
  end
  helper_method :mobile_device?

  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      #flash[:alert] = "You must be an admin to do that."
      activity_log = current_user.activity_logs.first
      if activity_log
        log_entry = activity_log.log_entries.where(date: Date.today).first
        if log_entry
          redirect_to [:edit, log_entry.activity_log, log_entry]
        else
          redirect_to activity_log.new_log_entry_url(Date.today)
        end
      else
        survey = Survey.find_by_county_id(current_user.county_id)
        if survey
          sign_out(current_user)
          flash[:notice] = "Please contact your MAA coordinator and ask them to create an activity log for your account."
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
