class UserMomentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_survey
  before_filter :find_user_moment, except: [:index, :new, :create]

  def show
  end

  private
    def find_survey
      @survey = Survey.find(params[:survey_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The survey you were looking" +
          " for could not be found."
      redirect_to surveys_path
    end

    def find_user_moment
      if @survey
        @user_moment = @survey.user_moments.find(params[:id])
      else
        @user_moment = UserMoment.find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The record you were looking " +
          "for could not be found."
      redirect_to @survey
    end
end
