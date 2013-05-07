class LogEntriesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_activity_log
	before_filter :find_log_entry, only: [:show, :edit, :update, :destroy]

  def new
    @log_entry = @activity_log.build_log_entry(params[:date])
    @log_entry.build_activities
  end

  def create
    @log_entry = @activity_log.log_entries.build(params[:log_entry])
    if @log_entry.save
      flash[:success] = "Log entry has been created."
      redirect_to [@activity_log, @log_entry]
    else
      render :new
    end
  end

	def show
		# @activity_categories = ActivityCategory.order(:code)
		@activities = @log_entry.activities.order(:id)
	end

  def edit
    @activities = @log_entry.activities.order(:id).limit(4)
  end

  def update
    if @log_entry.update_attributes(params[:log_entry])
      flash[:success] = "Log entry has been updated."
      redirect_to [@activity_log, @log_entry]
    else
      render :edit
    end
  end

  def destroy
    @log_entry.destroy
    flash[:notice] = "Log entry has been deleted."
    redirect_to [@activity_log.survey, @activity_log]
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
