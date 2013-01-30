class ActivityLogsController < ApplicationController
  before_filter :find_survey
  before_filter :find_activity_log, only: [:show, :edit, :update, :destroy]

  def new
    @activity_log = @survey.activity_logs.build
  end

  def create
    @activity_log = @survey.activity_logs.build(params[:activity_log])
    if @activity_log.save
      flash[:notice] = "Activity log has been created."
      redirect_to [@survey, @activity_log]
    else
      flash[:alert] = "Activity log has not been created."
      render :new
    end
  end

  def show

  end

  private
    def find_survey
      @survey = Survey.find(params[:survey_id])
    end

    def find_activity_log
      @activity_log = @survey.activity_logs.find(params[:id])
    end
end
