class UserMomentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_moments = current_user.user_moments.active.all
  end
end
