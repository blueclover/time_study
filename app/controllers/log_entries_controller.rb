class LogEntriesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_activity_log
	before_filter :find_log_entry, only: [:show, :edit, :update, :destroy]
  before_filter :build_favorites

  def new
    # log_entry = @activity_log.log_entries.where(date: params[:date]).first
    # log_entry.destroy if log_entry

    @log_entry = @activity_log.build_log_entry(params[:date], 8)
    @log_entry.build_activities
  end

  def create
    @log_entry = @activity_log.log_entries.build(params[:log_entry])
    # raise "error"
    if @log_entry.save
      if @log_entry.sum_hours <= @log_entry.hours
        flash[:success] = "Log entry has been created."
        redirect_to [@activity_log, @log_entry]
      else
        # redirect_to edit_activity_log_log_entry_path(@activity_log, @log_entry), invalid: true
        redirect_to id: @log_entry.id, action: :edit, invalid: true
      end
    else
      render :new
    end
  end

	def show
		# @activity_categories = ActivityCategory.order(:code)
		@activities = @log_entry.activities.order(:activity_category_id)
	end

  def edit
    @activities = @log_entry.activities.order(:activity_category_id)
    @log_entry.check_hours if params[:invalid]
  end

  def update
    if @log_entry.update_attributes(params[:log_entry])
      if @log_entry.sum_hours <= @log_entry.hours
        flash[:success] = "Log entry has been updated."
        redirect_to [@activity_log, @log_entry]
      else
        redirect_to action: 'edit', invalid: true
      end
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

    def build_favorites
      @favorite_activities = current_user.favorite_activities
      @favorite_activities += @log_entry.activity_ids_with_hours if @log_entry
    end
end
