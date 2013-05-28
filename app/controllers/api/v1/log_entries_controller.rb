class Api::V1::LogEntriesController < Api::V1::BaseController
	def index
		respond_with(ActivityLog.accessible_to(current_user).first.log_entries)
	end
end