class SurveysController < ApplicationController
  def index

  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(params[:survey])
    if @survey.save
      flash[:notice] = "Survey has been created."
      redirect_to @survey
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end
end
