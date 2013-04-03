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
    fields = {q1selection: :q1text, q2selection: :q2text, q3selection: :q3text}
    fields.each do |selection, text|
      if params[:response][text].blank?
        option = ResponseOption.find_by_id(params[:response][selection])
        params[:response][text] = option.description
      end
    end
    @response = @user_moment.build_response(params[:response])
    @response.activity_category_id = 
          ResponseOption.find_by_id(@response.q2selection).activity_category_id
    if @response.save
      sign_out(current_user)
      flash[:success] = "Thank you for your participation."
      redirect_to new_user_session_path
    else
      flash[:error] = "Your response has not been saved."
      render :new
    end
  end

  def show
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
      flash[:alert] = "The record you were looking" +
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
