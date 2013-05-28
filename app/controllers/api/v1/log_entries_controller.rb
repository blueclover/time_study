class Api::V1::LogEntriesController < Api::V1::BaseController

	def index
		respond_with(ActivityLog.accessible_to(current_user).first.log_entries)
	end

	def create
		activity_log = ActivityLog.accessible_to(current_user).first
		log_entry = activity_log.log_entries.build(params[:log_entry])
		if log_entry.save
			respond_with(log_entry, :location => api_v1_log_entry_path(log_entry))
		else
			respond_with(log_entry)
		end
	end
end