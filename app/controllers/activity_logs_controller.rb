class ActivityLogsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_survey
  before_filter :find_activity_log, only: [:show, :edit, :update, :destroy]

  def new
    @activity_log = @survey.activity_logs.build
  end

  def create
    @activity_log = @survey.activity_logs.build(params[:activity_log])
    @activity_log.user = current_user
    if @activity_log.save
      5.times do |n|
        date = n.days.since(@activity_log.start_date).to_date
        entry = @activity_log.log_entries.create!(date: date)
        ActivityCategory.order(:code).each do |activity|
          entry.activities.create!(activity_category: activity)
        end
      end
      flash[:notice] = "Activity log has been created."
      redirect_to [@survey, @activity_log]
    else
      flash[:alert] = "Activity log has not been created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @activity_log.update_attributes(params[:activity_log])
      flash[:notice] = "Activity Log has been updated."
      redirect_to [@survey, @activity_log]
    else
      flash[:alert] = "Activity Log has not been updated."
      render :edit
    end
  end

  def destroy
    @activity_log.destroy
    flash[:notice] = "Activity Log has been deleted."
    redirect_to @survey
  end

  private
    def find_survey
      @survey = Survey.find(params[:survey_id])
    end

    def find_activity_log
      @activity_log = @survey.activity_logs.find(params[:id])
    end
end
