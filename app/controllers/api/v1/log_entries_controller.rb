class Api::V1::LogEntriesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user!

  respond_to :json
	
	def index
		if activity_log = ActivityLog.where(user_id: current_user.id).first
			respond_with(activity_log.log_entries)
		else
			respond_with({ error: "No log entries." })
		end
	end

	def create
		activity_log = ActivityLog.where(user_id: current_user.id).first
		log_entry = activity_log.log_entries.build(params[:log_entry])
		if log_entry.save
		# 	respond_with(log_entry, :location => api_v1_log_entry_path(log_entry))
		# else
		# 	respond_with(log_entry)
		# end
		  render :status => :ok,
             :json => { :success => true,
                        :info => "Log entry successfully submitted.",
                        :data => {} }
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => log_entry.errors,
                        :data => {} }
    end
	end
end