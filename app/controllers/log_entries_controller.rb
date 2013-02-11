class LogEntriesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_log_entry, only: :show

	def show
		# @activity_categories = ActivityCategory.order(:code)
		@activities = @log_entry.activities.order(:id)
	end

	private
    def find_log_entry
      @log_entry = LogEntry.find(params[:id])
    end
end
