class ResponsesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user_moment
  before_filter :find_response, except: [:index, :new, :create]

  def new
    @response = @user_moment.build_response
    @q1options = ResponseOption.for_question(1).all
    @q2options = ResponseOption.for_question(2).all
    @q3options = ResponseOption.for_question(3).all
  end

  def create
    @response = @user_moment.build_response(params[:response])
    if @response.save
      flash[:success] = "Thank you for your participation."
      redirect_to @response
    else
      flash[:error] = "Your response has not been saved."
      render :new
    end
  end

  def show
    unless @user_moment.user_responded?
      redirect_to '/'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def find_user_moment
      @user_moment = UserMoment.find(params[:user_moment_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The survey you were looking" +
          " for could not be found."
      redirect_to surveys_path
    end

    def find_response
      if @user_moment
        @response = @user_moment.response
      else
        @response = UserMoment.find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The record you were looking" +
          " for could not be found."
      redirect_to @survey
    end
end
