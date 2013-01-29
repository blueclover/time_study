class SurveysController < ApplicationController
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
    @survey = Survey.find(params[:id])
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Survey has been updated."
      redirect_to @survey
    else
      flash[:error] = "Survey has not been updated."
      render :edit
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    flash[:notice] = "Survey has been deleted."
    redirect_to surveys_path
  end
end
