class SurveysController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :show]
  before_filter :authorize_admin!, except: [:index, :show]
  before_filter :find_survey, only: [:show, :edit, :update, :destroy]

  def index
    @surveys = Survey.all
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(params[:survey])
    if @survey.save
      flash[:notice] = "Survey has been created."
      redirect_to @survey
    else
      flash[:error] = "Survey has not been created."
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Survey has been updated."
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

  private
    def find_survey
      @survey = Survey.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The survey you were looking" +
          " for could not be found."
      redirect_to surveys_path
    end
end
