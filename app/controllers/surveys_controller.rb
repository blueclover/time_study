class SurveysController < ApplicationController
  before_filter :authorize_admin!
  before_filter :find_survey, except: [:index, :new, :create]

  def index
    @surveys = Survey.order(:id)
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(params[:survey])
    if @survey.save
      flash[:success] = "Survey has been created."
      redirect_to @survey
    else
      flash[:error] = "Survey has not been created."
      render :new
    end
  end

  def show
    @user_moments = @survey.user_moments.order(:moment)
  end

  def edit

  end

  def update
    if @survey.update_attributes(params[:survey])
      flash[:success] = "Survey has been updated."
      redirect_to @survey
    else
      flash[:error] = "Survey has not been updated."
      render :edit
    end
  end

  def destroy
    @survey.destroy
    flash[:notice] = "Survey has been deleted."
    redirect_to surveys_path
  end

  def summary_table
    @table = @survey.summary_table.sort_by { |x| x[0][:code] }
  end

  private
    def find_survey
      @survey = Survey.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The survey you were looking" +
          " for could not be found."
      redirect_to surveys_path
    end
end
