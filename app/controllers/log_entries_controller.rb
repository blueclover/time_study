class LogEntriesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_activity_log
	before_filter :find_log_entry, only: :show

	def show
		# @activity_categories = ActivityCategory.order(:code)
		@activities = @log_entry.activities.order(:id)
	end

	private
    def find_activity_log
      @activity_log = ActivityLog.find(params[:activity_log_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The record you were looking" +
          " for could not be found."
      redirect_to surveys_path
    end

    def find_log_entry
      @log_entry = LogEntry.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The record you were looking" +
          " for could not be found."
      redirect_to [@activity_log.survey, @activity_log]
    end
end
