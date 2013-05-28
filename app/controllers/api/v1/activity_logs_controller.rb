class Api::V1::ActivityLogsController < Api::V1::BaseController
	def index
		respond_with(ActivityLog.accessible_to(current_user))
	end
end